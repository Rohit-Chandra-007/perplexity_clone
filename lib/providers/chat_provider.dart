import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_models.dart';
import '../services/websocket_service.dart';
import 'history_provider.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  late final WebSocketService _webSocketService;
  StreamSubscription? _searchSubscription;
  StreamSubscription? _contentSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _completionSubscription;

  @override
  ChatState build() {
    _webSocketService = WebSocketService();
    _initializeSubscriptions();
    _webSocketService.connect();
    
    ref.onDispose(() {
      _cancelSubscriptions();
      _webSocketService.dispose();
    });

    return const ChatState();
  }

  void _initializeSubscriptions() {
    _connectionSubscription = _webSocketService.connectionStream.listen((isConnected) {
      state = state.copyWith(isConnected: isConnected);
    });

    _searchSubscription = _webSocketService.searchResultStream.listen((sources) {
      if (state.messages.isNotEmpty) {
        final updatedMessages = [...state.messages];
        final lastIndex = updatedMessages.length - 1;
        updatedMessages[lastIndex] = updatedMessages[lastIndex].copyWith(
          sources: sources,
          status: ChatStatus.streaming,
        );
        state = state.copyWith(messages: updatedMessages);
      }
    });

    _contentSubscription = _webSocketService.contentStream.listen((content) {
      if (state.messages.isNotEmpty) {
        final updatedMessages = [...state.messages];
        final lastIndex = updatedMessages.length - 1;
        final currentAnswer = updatedMessages[lastIndex].answer;
        
        // If content is empty, mark as completed
        if (content.isEmpty) {
          updatedMessages[lastIndex] = updatedMessages[lastIndex].copyWith(
            status: ChatStatus.completed,
          );
        } else {
          updatedMessages[lastIndex] = updatedMessages[lastIndex].copyWith(
            answer: currentAnswer + content,
            status: ChatStatus.streaming,
          );
        }
        state = state.copyWith(messages: updatedMessages);
      }
    });

    _errorSubscription = _webSocketService.errorStream.listen((error) {
      state = state.copyWith(error: error);
      if (state.messages.isNotEmpty) {
        final updatedMessages = [...state.messages];
        final lastIndex = updatedMessages.length - 1;
        updatedMessages[lastIndex] = updatedMessages[lastIndex].copyWith(
          status: ChatStatus.error,
        );
        state = state.copyWith(messages: updatedMessages);
      }
    });

    _completionSubscription = _webSocketService.completionStream.listen((_) {
      if (state.messages.isNotEmpty) {
        final updatedMessages = [...state.messages];
        final lastIndex = updatedMessages.length - 1;
        final completedMessage = updatedMessages[lastIndex].copyWith(
          status: ChatStatus.completed,
        );
        updatedMessages[lastIndex] = completedMessage;
        state = state.copyWith(messages: updatedMessages);
        
        // Save to history
        ref.read(historyProvider.notifier).addMessage(completedMessage);
      }
    });
  }

  void _cancelSubscriptions() {
    _searchSubscription?.cancel();
    _contentSubscription?.cancel();
    _connectionSubscription?.cancel();
    _errorSubscription?.cancel();
    _completionSubscription?.cancel();
  }

  Future<void> sendQuery(String query) async {
    if (query.trim().isEmpty) return;

    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      query: query,
      timestamp: DateTime.now(),
      status: ChatStatus.loading,
    );

    state = state.copyWith(
      messages: [...state.messages, message],
      error: null,
    );

    try {
      await _webSocketService.sendQuery(query);
    } catch (e) {
      // Handle error by updating the message status
      if (state.messages.isNotEmpty) {
        final updatedMessages = [...state.messages];
        final lastIndex = updatedMessages.length - 1;
        updatedMessages[lastIndex] = updatedMessages[lastIndex].copyWith(
          status: ChatStatus.error,
        );
        state = state.copyWith(
          messages: updatedMessages,
          error: 'Failed to send query: ${e.toString()}',
        );
      }
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearMessages() {
    state = state.copyWith(messages: []);
  }
}

@riverpod
ChatMessage? currentMessage(Ref ref) {
  final chatState = ref.watch(chatProvider);
  return chatState.messages.isNotEmpty ? chatState.messages.last : null;
}

@riverpod
bool isLoading(Ref ref) {
  final currentMsg = ref.watch(currentMessageProvider);
  return currentMsg?.status == ChatStatus.loading;
}

@riverpod
bool isStreaming(Ref ref) {
  final currentMsg = ref.watch(currentMessageProvider);
  return currentMsg?.status == ChatStatus.streaming;
}
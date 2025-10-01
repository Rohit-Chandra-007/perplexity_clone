import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_models.dart';
import '../services/chat_history_service.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  Future<List<ChatMessage>> build() async {
    return await ChatHistoryService.loadHistory();
  }

  Future<void> addMessage(ChatMessage message) async {
    // Only save completed messages to history
    if (message.status == ChatStatus.completed && message.answer.isNotEmpty) {
      await ChatHistoryService.saveMessage(message);
      // Refresh the state
      ref.invalidateSelf();
    }
  }

  Future<void> deleteMessage(String messageId) async {
    await ChatHistoryService.deleteMessage(messageId);
    ref.invalidateSelf();
  }

  Future<void> clearHistory() async {
    await ChatHistoryService.clearHistory();
    ref.invalidateSelf();
  }
}

// Optional: Stream-based provider for real-time updates
@riverpod
Stream<List<ChatMessage>> historyStream(Ref ref) {
  return ChatHistoryService.historyStream();
}
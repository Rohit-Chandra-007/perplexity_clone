import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';
import '../models/chat_models.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocket? _webSocket;
  StreamSubscription? _messageSubscription;
  final String _url = 'ws://localhost:8000/ws/chat';
  bool _isDisposed = false;

  final _connectionController = StreamController<bool>.broadcast();
  final _searchResultController =
      StreamController<List<SearchResult>>.broadcast();
  final _contentController = StreamController<String>.broadcast();
  final _errorController = StreamController<String>.broadcast();
  final _completionController = StreamController<void>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;
  Stream<List<SearchResult>> get searchResultStream =>
      _searchResultController.stream;
  Stream<String> get contentStream => _contentController.stream;
  Stream<String> get errorStream => _errorController.stream;
  Stream<void> get completionStream => _completionController.stream;

  bool get isConnected => _webSocket != null && !_isDisposed;

  Future<void> connect() async {
    if (_isDisposed) return;

    // Close existing connection if any
    await disconnect();

    try {
      if (kDebugMode) {
        print('Connecting to WebSocket: $_url');
      }

      _webSocket = WebSocket(Uri.parse(_url));

      _messageSubscription = _webSocket!.messages.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnection,
        cancelOnError: false,
      );

      if (!_connectionController.isClosed) {
        _connectionController.add(true);
      }

      if (kDebugMode) {
        print('WebSocket connected successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to connect to WebSocket: $e');
      }
      _handleError(e);
    }
  }

  void _handleMessage(dynamic message) {
    if (_isDisposed) return;

    try {
      final data = json.decode(message);

      if (kDebugMode) {
        print('Received WebSocket message: ${data['type']}');
      }

      switch (data['type']) {
        case 'search_result':
          if (!_searchResultController.isClosed) {
            final results = (data['data'] as List)
                .map(
                  (item) => SearchResult(
                    title: item['title'] ?? '',
                    url: item['url'] ?? '',
                    snippet: item['snippet'],
                  ),
                )
                .toList();
            _searchResultController.add(results);
          }
          break;

        case 'content':
          if (!_contentController.isClosed) {
            _contentController.add(data['data'] ?? '');
          }
          break;

        case 'complete':
          if (kDebugMode) {
            print('Response completed');
          }
          if (!_completionController.isClosed) {
            _completionController.add(null);
          }
          break;

        case 'error':
          _handleError('Server error: ${data['data']}');
          break;

        default:
          if (kDebugMode) {
            print('Unknown message type: ${data['type']}');
          }
      }
    } catch (e) {
      _handleError('Error decoding message: $e');
    }
  }

  void _handleError(dynamic error) {
    if (_isDisposed) return;

    if (kDebugMode) {
      print('WebSocket error: $error');
    }

    if (!_errorController.isClosed) {
      _errorController.add(error.toString());
    }

    if (!_connectionController.isClosed) {
      _connectionController.add(false);
    }
  }

  void _handleDisconnection() {
    if (_isDisposed) return;

    if (kDebugMode) {
      print('WebSocket disconnected');
    }

    _webSocket = null;
    _messageSubscription?.cancel();
    _messageSubscription = null;

    if (!_connectionController.isClosed) {
      _connectionController.add(false);
    }
  }

  Future<void> sendQuery(String query) async {
    if (_isDisposed) return;

    // Ensure connection is established
    if (_webSocket == null) {
      await connect();
      // Wait for connection to establish
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // Retry connection if still not connected
    if (_webSocket == null) {
      _handleError('Failed to establish WebSocket connection');
      return;
    }

    if (!_isDisposed) {
      try {
        final message = json.encode({'query': query});
        _webSocket!.send(message);

        if (kDebugMode) {
          print('Sent query: $query');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error sending query: $e');
        }
        _handleError('Error sending query: $e');
        rethrow; // Re-throw to let the provider handle it
      }
    } else {
      _handleError('WebSocket service is disposed');
    }
  }

  Future<void> disconnect() async {
    if (_webSocket != null) {
      try {
        await _messageSubscription?.cancel();
        _messageSubscription = null;

        _webSocket?.close();
        _webSocket = null;

        if (!_connectionController.isClosed) {
          _connectionController.add(false);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error during disconnect: $e');
        }
      }
    }
  }

  Future<void> dispose() async {
    _isDisposed = true;

    await disconnect();

    // Close all stream controllers
    await _connectionController.close();
    await _searchResultController.close();
    await _contentController.close();
    await _errorController.close();
    await _completionController.close();
  }
}

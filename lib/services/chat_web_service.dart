import "dart:async";
import "dart:convert";
import "package:flutter/foundation.dart";
import "package:web_socket_client/web_socket_client.dart";

class ChatWebService {
  // Singleton instance
  static final ChatWebService _instance = ChatWebService._internal();

  // Factory constructor
  factory ChatWebService() {
    return _instance;
  }

  ChatWebService._internal();

  WebSocket? _webSocket;
  final String _url = 'ws://localhost:8000/ws/chat';

  final _searchController = StreamController<Map<String, dynamic>>.broadcast();
  final _contentController = StreamController<Map<String, dynamic>>.broadcast();
  final _queryController = StreamController<String>.broadcast();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchController.stream;

  Stream<Map<String, dynamic>> get contentStream => _contentController.stream;

  Stream<String> get queryStream => _queryController.stream;

  /// Connect to the WebSocket server.
  /// If the WebSocket is already connected, it will not connect again.
  void connect() {
    _webSocket = WebSocket(Uri.parse(_url));
    _webSocket!.messages.listen(
      (message) {
        try {
          final data = json.decode(message);
          if (data['type'] == 'search_result') {
            _searchController.add(data);
          } else if (data['type'] == 'content') {
            _contentController.add(data);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error decoding message: $e');
          }
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('WebSocket error: $error');
        }
      },
    );
  }

  /// Send a message to the WebSocket server.
  /// If the WebSocket is not connected, it will not send the message.
  /// If the message is empty, it will not send the message.
  void chat(String query) {
    if (_webSocket != null) {
      if (kDebugMode) {
        print('Sending message: $query');
      }
      _queryController.add(query);
      _webSocket!.send(json.encode({'query': query}));
    } else {
      if (kDebugMode) {
        print('WebSocket is not connected');
      }
    }
  }
}

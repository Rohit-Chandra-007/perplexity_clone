import "dart:convert";

import "package:web_socket_client/web_socket_client.dart";

class ChatWebService {
  WebSocket? _webSocket;
  final String _url = 'ws://localhost:8000/ws/chat';

  void connect() {
    _webSocket = WebSocket(Uri.parse(_url));
    _webSocket!.messages.listen(
      (message) {
        try {
          final data = json.decode(message);
          print(data['type']);
        } catch (e) {
          print('Error decoding message: $e');
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
    );
  }
}

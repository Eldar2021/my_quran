import 'dart:async';
import 'dart:developer';

import 'package:web_socket_client/web_socket_client.dart';

class HatimWebSocketClient {
  HatimWebSocketClient._();

  static final HatimWebSocketClient _instance = HatimWebSocketClient._();

  static HatimWebSocketClient get instance => _instance;

  WebSocket? _socket;
  String? _lastToken;

  Stream<dynamic> get messages => _socket?.messages ?? const Stream.empty();

  Stream<ConnectionState> get connection => _socket?.connection ?? const Stream.empty();

  bool get isConnected => _socket?.connection.state is Connected;

  /// Connects to the WebSocket with the given [token].
  /// Uses a BackoffStrategy for auto-reconnection.
  void connect(String token) {
    if (_socket != null && _lastToken == token) {
      // Already connected or connecting with the same token
      return;
    }

    _lastToken = token;
    _disconnectInternal(isIntentional: false);

    final uri = Uri.parse('wss://myquran.life/ws/?token=$token');

    // Create a WebSocket client with auto-reconnect backoff
    _socket = WebSocket(
      uri,
      backoff: const ConstantBackoff(Duration(seconds: 2)),
    );

    log('HatimWebSocketClient: Connecting to $uri');
  }

  /// Disconnects the WebSocket intentionally.
  /// This should be called when navigating away or backgrounding the app.
  void disconnect() {
    log('HatimWebSocketClient: Intentional disconnect');
    _disconnectInternal(isIntentional: true);
    _lastToken = null;
  }

  void _disconnectInternal({required bool isIntentional}) {
    if (_socket != null) {
      _socket!.close();
      _socket = null;
    }
  }

  void send(String data) {
    if (_socket != null) {
      _socket!.send(data);
    } else {
      log('HatimWebSocketClient: Cannot send message, socket is null');
    }
  }
}

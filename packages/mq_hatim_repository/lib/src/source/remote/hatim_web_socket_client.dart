import 'dart:async';
import 'dart:developer';

import 'package:web_socket_client/web_socket_client.dart';

class HatimWebSocketClient {
  HatimWebSocketClient._();

  static final HatimWebSocketClient _instance = HatimWebSocketClient._();

  static HatimWebSocketClient get instance => _instance;

  WebSocket? _socket;
  String? _lastToken;

  StreamController<dynamic>? _messagesController;
  StreamController<ConnectionState>? _connectionController;

  StreamSubscription<dynamic>? _messagesSubscription;
  StreamSubscription<ConnectionState>? _connectionSubscription;

  Stream<dynamic> get messages {
    _messagesController ??= StreamController<dynamic>.broadcast();
    return _messagesController!.stream;
  }

  Stream<ConnectionState> get connection {
    _connectionController ??= StreamController<ConnectionState>.broadcast();
    return _connectionController!.stream;
  }

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

    // Ensure controllers are initialized
    _messagesController ??= StreamController<dynamic>.broadcast();
    _connectionController ??= StreamController<ConnectionState>.broadcast();

    final uri = Uri.parse('wss://myquran.life/ws/?token=$token');

    // Create a WebSocket client with auto-reconnect backoff
    _socket = WebSocket(
      uri,
      backoff: const ConstantBackoff(Duration(seconds: 2)),
    );

    // Forward events to persistent controllers
    _messagesSubscription = _socket!.messages.listen(
      (event) {
        _messagesController?.add(event);
      },
      onError: (Object e) {
        _messagesController?.addError(e);
      },
      onDone: () {
        // Do not close the controller here, as we might reconnect
      },
    );

    _connectionSubscription = _socket!.connection.listen(
      (state) {
        _connectionController?.add(state);
      },
      onError: (Object e) {
        _connectionController?.addError(e);
      },
      onDone: () {
        // Do not close the controller here
      },
    );

    log('HatimWebSocketClient: Connecting to $uri');
  }

  /// Disconnects the WebSocket intentionally.
  /// This should be called when navigating away or backgrounding the app.
  void disconnect() {
    log('HatimWebSocketClient: Intentional disconnect');
    _disconnectInternal(isIntentional: true);
    _lastToken = null;
    // Optionally emit a disconnected state or clear state
    _connectionController?.add(const Disconnected());
  }

  void _disconnectInternal({required bool isIntentional}) {
    _messagesSubscription?.cancel();
    _connectionSubscription?.cancel();
    _messagesSubscription = null;
    _connectionSubscription = null;

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

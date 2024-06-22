import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_pages_state.dart';

class HatimPagesCubit extends Cubit<HatimPagesState> {
  HatimPagesCubit() : super(const HatimPagesState());

  WebSocketChannel? channel;

  void connect(String pageId, String token) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://myquran.life/ws/?token=$token'),
    );
    channel!.sink.add(
      jsonEncode({
        'type': 'user_pages',
        'pageId': pageId,
      }),
    );

    channel!.stream.listen(
      onMessage,
      onError: onError,
      onDone: onDone,
    );
  }

  void onMessage(dynamic message) {
    try {
      final decodedMessage = jsonDecode(message as String) as Map<String, dynamic>;
      if (decodedMessage.containsKey('data') && decodedMessage['data'] is List) {
        final data = decodedMessage['data'] as List<dynamic>;
        final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
        if (!isClosed) emit(state.copyWith(pages: items));
      } else {
        throw FormatException('Unexpected JSON structure: $decodedMessage');
      }
    } catch (e) {
      if (!isClosed) emit(state.copyWith(exception: Exception('Error parsing message: $e')));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (!isClosed) emit(state.copyWith(exception: Exception('WebSocket error: $error')));
  }

  void onDone() {
    if (!isClosed) emit(state.copyWith(exception: Exception('WebSocket connection closed')));
  }

  void sendPage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = state.pages!.map((page) => page!.id).toList();
      channel?.sink.add(
        jsonEncode({
          'type': 'user_pages',
          'pageIds': pageIds,
          'username': username,
          'token': token,
        }),
      );
    }
  }

  void donePage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = state.pages!.map((page) => page!.id).toList();
      channel?.sink.add(
        jsonEncode({
          'type': 'done',
          'pageIds': pageIds,
          'username': username,
          'token': token,
        }),
      );
    }
  }

  @override
  Future<void> close() {
    channel?.sink.close(status.goingAway);
    return super.close();
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}

import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/models/models.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_pages_state.dart';

class HatimPagesCubit extends Cubit<HatimPagesState> {
  HatimPagesCubit() : super(const HatimPagesState());

  late WebSocketChannel channel;
  late StreamSubscription<dynamic> _streamSubscription;

  void connect(String username, String token) {
    channel = IOWebSocketChannel.connect(apiConst.baseSocket);

    _streamSubscription = channel.stream.listen(
      onMessage,
      onError: onError,
      onDone: onDone,
    );

    sendConnectMessage(username, token);
  }

  void onMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as List<dynamic>;
      if (data.isNotEmpty) {
        final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
        if (!isClosed) emit(state.copyWith(pages: items));
      } else {
        if (!isClosed) emit(state.copyWith(pages: <HatimPages>[]));
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

  void sendConnectMessage(String username, String token) {
    final connectMessage = jsonEncode({'username': username, 'token': token});
    channel.sink.add(connectMessage);
  }

  void sendPage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = state.pages!.map((page) => page!.id).toList();
      final message = jsonEncode({'pageIds': pageIds, 'username': username});
      channel.sink.add(message);
    }
  }

  void donePage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = state.pages!.map((page) => page!.id).toList();
      final message = jsonEncode({'pageIds': pageIds, 'username': username, 'status': 'done'});
      channel.sink.add(message);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    channel.sink.close();
    return super.close();
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}

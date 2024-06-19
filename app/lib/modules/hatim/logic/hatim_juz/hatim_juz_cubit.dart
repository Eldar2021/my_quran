import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit(this.juzNumber) : super(const HatimJuzState());

  final int juzNumber;

  late WebSocketChannel channel;
  late StreamSubscription<dynamic> _streamSubscription;

  void connect(String hatimId, String token) {
    channel = IOWebSocketChannel.connect(apiConst.baseSocket);

    _streamSubscription = channel.stream.listen(
      onMessage,
      onError: onError,
      onDone: onDone,
    );

    sendConnectMessage(hatimId, token);
  }

  void onMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as List<dynamic>;
      final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
      if (!isClosed) emit(HatimJuzState(pages: items, status: FetchStatus.success));
    } catch (e) {
      if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
  }

  void onDone() {
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.success));
  }

  void sendConnectMessage(String juzId, String token) {
    final connectMessage = jsonEncode({'juzId': juzId, 'token': token});
    channel.sink.add(connectMessage);
  }

  void selectPage(String pageId, String token, String username) {
    final message = jsonEncode({'pageId': pageId, 'username': username});
    channel.sink.add(message);
  }

  void unSelectPage(String pageId, String token, String username) {
    final message = jsonEncode({'pageId': pageId, 'username': username, 'status': 'unselect'});
    channel.sink.add(message);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    channel.sink.close();
    return super.close();
  }
}

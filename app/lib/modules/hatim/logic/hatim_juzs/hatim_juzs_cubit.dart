import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:my_quran/models/hatim/hatim_juz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_juzs_state.dart';

class HatimJuzsCubit extends Cubit<HatimJuzsState> {
  HatimJuzsCubit() : super(const HatimJuzsState());

  late final WebSocketChannel channel;

  void connect(String token) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://myquran.life/ws/?token=$token'),
    );

    channel.stream.listen(
      onMessage,
      onError: onError,
      onDone: onDone,
    );

    log('WebSocket connected');
  }

  void onMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as List<dynamic>;
      final items = data.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
      if (!isClosed) emit(HatimJuzsState(hatimJuzs: items));
      log('Received message: $message');
    } catch (e) {
      if (!isClosed) emit(HatimJuzsState(erorText: 'Error parsing message: $e'));
      log('Error parsing message: $e');
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (!isClosed) emit(HatimJuzsState(erorText: 'WebSocket error: $error'));
    log('WebSocket error: $error');
  }

  void onDone() {
    if (!isClosed) emit(const HatimJuzsState(erorText: 'WebSocket connection closed'));
    log('WebSocket connection closed');
  }

  void sendPage(String username, String token) {
    if (state.hatimJuzs != null && state.hatimJuzs!.isNotEmpty) {
      final pageIds = List.generate(state.hatimJuzs!.length, (index) => state.hatimJuzs![index].id);
      final message = jsonEncode({'pageIds': pageIds, 'username': username});
      channel.sink.add(message);
      log('Sent page update: $message');
    }
  }

  void donePage(String username, String token) {
    if (state.hatimJuzs != null && state.hatimJuzs!.isNotEmpty) {
      final pageIds = List.generate(state.hatimJuzs!.length, (index) => state.hatimJuzs![index].id);
      final message = jsonEncode({'pageIds': pageIds, 'username': username, 'status': 'done'});
      channel.sink.add(message);
      log('Marked page as done: $message');
    }
  }

  @override
  Future<void> close() {
    channel.sink.close(status.goingAway);
    log('WebSocket channel closed');
    return super.close();
  }
}

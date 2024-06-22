import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_juzs_state.dart';

class HatimJuzsCubit extends Cubit<HatimJuzsState> {
  HatimJuzsCubit() : super(const HatimJuzsState());

  WebSocketChannel? channel;

  void connect(String token, String id) {
    if (channel == null) {
      channel = WebSocketChannel.connect(
        Uri.parse('wss://myquran.life/ws/?token=$token'),
      );
      channel!.sink.add(
        jsonEncode({
          'type': 'list_of_juz',
          'hatim_id': id,
        }),
      );

      channel!.stream.listen(
        onMessage,
        onError: onError,
        onDone: onDone,
      );
    }
  }

  void onMessage(dynamic message) {
    try {
      final decodedMessage = jsonDecode(message as String) as Map<String, dynamic>;
      if (decodedMessage.containsKey('data') && decodedMessage['data'] is List) {
        final data = decodedMessage['data'] as List<dynamic>;
        final items = data.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
        if (!isClosed) emit(HatimJuzsState(hatimJuzs: items));
      } else {
        throw FormatException('Unexpected JSON structure: $decodedMessage');
      }
    } catch (e) {
      if (!isClosed) emit(HatimJuzsState(erorText: 'Error parsing message: $e'));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (!isClosed) emit(HatimJuzsState(erorText: 'WebSocket error: $error'));
  }

  void onDone() {
    if (!isClosed) emit(const HatimJuzsState(erorText: 'WebSocket connection closed'));
  }

  @override
  Future<void> close() {
    channel?.sink.close(status.goingAway);
    return super.close();
  }
}

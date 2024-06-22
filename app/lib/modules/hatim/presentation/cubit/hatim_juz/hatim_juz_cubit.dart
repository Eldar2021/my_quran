import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit(this.juzNumber) : super(const HatimJuzState());

  final int juzNumber;

  late final WebSocketChannel channel;

  void connect(String juzId, String token) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://myquran.life/ws/?token=$token'),
    );
    channel.sink.add(
      jsonEncode({
        'type': 'list_of_page',
        'juz_id': juzId,
      }),
    );

    channel.stream.listen(
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
        print(data);
        final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
        // print(items);
        if (!isClosed) emit(HatimJuzState(pages: items, status: FetchStatus.success));
      } else {
        throw FormatException('Unexpected JSON structure: $decodedMessage');
      }
    } catch (e, s) {
      if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
      // log(e);
      print(e);
      print(s);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
  }

  void onDone() {
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
  }

  void selectPage(String pageId, String token, String username) {
    channel.sink.add(
      jsonEncode({
        'type': 'book',
        'pageId': pageId,
      }),
    );
  }

  void unSelectPage(String pageId, String token, String username) {
    channel.sink.add(
      jsonEncode({
        'type': 'to_do',
        'pageId': pageId,
      }),
    );
  }

  @override
  Future<void> close() {
    channel.sink.close(status.goingAway);
    return super.close();
  }
}

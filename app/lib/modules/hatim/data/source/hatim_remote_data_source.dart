import 'dart:async';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HatimRemoteDataSource {
  HatimRemoteDataSource({
    required this.token,
    required this.remoteClient,
  });

  final RemoteClient remoteClient;
  final String token;

  late final WebSocketChannel channel;

  Future<Either<HatimReadModel, Exception>> getHatim(String token) {
    return remoteClient.post(
      apiConst.joinToHatim,
      fromJson: HatimReadModel.fromJson,
      token: token,
    );
  }

  void connectToSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://myquran.life/ws/?token=$token'),
    );
  }

  // Stream<Map<String, dynamic>> listen(
  //   void Function(dynamic)? onData, {
  //   Function? onError,
  //   void Function()? onDone,
  //   bool? cancelOnError,
  // }) {
  //   channel.stream.listen(
  //     (event) {
  //       final data = jsonDecode(event as String) as Map<String, dynamic>;

  //     },
  //     onError: onError,
  //     onDone: onDone,
  //     cancelOnError: cancelOnError,
  //   );
  // }
}

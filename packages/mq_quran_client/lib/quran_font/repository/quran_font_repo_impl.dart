import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class QuranFontRepoImpl implements QuranFontRepository {
  const QuranFontRepoImpl({
    required this.client,
  });

  final MqRemoteClient client;

  @override
  Future<void> getFontByPage(int pageNumber) {
    throw UnimplementedError();
  }

  // Future<void> _downloadFont(int pageNumber) async {
  //   try {
  //     final res = client.download(urlPath, savePath);
  //   } catch (e) {}
  // }
}

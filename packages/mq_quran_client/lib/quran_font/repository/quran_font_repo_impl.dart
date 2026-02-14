import 'dart:developer';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:path_provider/path_provider.dart';

@immutable
final class QuranFontRepoImpl implements QuranFontRepository {
  const QuranFontRepoImpl(this.client);

  final MqRemoteClient client;

  @override
  Future<QuranFontModel> getFontByPage(int pageNumber) async {
    try {
      final fonts = await Future.wait([
        _getFontByPage(pageNumber, false),
        _getFontByPage(pageNumber, true),
      ]);

      return QuranFontModel(
        normalFont: fonts[0],
        tajweedFont: fonts[1],
      );
    } catch (e) {
      log('Get Font Error: $e');
      rethrow;
    }
  }

  Future<File> _getFontByPage(int pageNumber, bool isTajweed) async {
    final fileName = pageNumber.toString().padLeft(3, '0');
    final dirName = isTajweed ? 'tajweed_fonts' : 'normal_fonts';

    final appDir = await getApplicationDocumentsDirectory();
    final savePath = '${appDir.path}/quran_fonts/$dirName/$fileName.woff2';
    final file = File(savePath);

    if (file.existsSync()) return file;
    await file.parent.create(recursive: true);

    try {
      final url = isTajweed
          ? QuranClientConstants.getTajweedUrl(fileName)
          : QuranClientConstants.getNormalUrl(fileName);

      await client.download(url, savePath);
      return file;
    } catch (e) {
      log('Download Error: $e');
      rethrow;
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:path_provider/path_provider.dart';

class QuranFontRemoteSource implements QuranFontSource {
  QuranFontRemoteSource(this.client);

  final MqRemoteClient client;

  Directory? _appDir;

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
    final appDir = await _getAppDir();

    final fontDir = Directory('${appDir.path}/quran_fonts/$dirName');
    if (!fontDir.existsSync()) await fontDir.create(recursive: true);

    final file = File('${fontDir.path}/$fileName.woff2');
    final tempFile = File('${fontDir.path}/$fileName.temp');

    if (file.existsSync()) return file;

    try {
      final url = isTajweed
          ? QuranClientConstants.getTajweedUrl(fileName)
          : QuranClientConstants.getNormalUrl(fileName);

      await client.download(url, tempFile.path);
      return await tempFile.rename(file.path);
    } catch (e) {
      if (tempFile.existsSync()) await tempFile.delete();
      log('Download Error: $e');
      rethrow;
    }
  }

  Future<Directory> _getAppDir() async {
    if (_appDir != null) return _appDir!;
    _appDir = await getApplicationDocumentsDirectory();
    return _appDir!;
  }
}

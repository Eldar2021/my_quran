import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

Future<void> downloadQuranFontsTtfFont() async {
  final dio = Dio();

  final currentProjectPath = '${Directory.current.path}/quran_data/ttf_fonts/';

  final dir = Directory(currentProjectPath);

  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }

  log('İndirme işlemi başlıyor...');

  for (var i = 1; i <= 604; i++) {
    final url =
        'https://raw.githubusercontent.com/quran/quran.com-frontend-next/production/public/fonts/quran/hafs/v2/ttf/p$i.ttf';

    final fileName = '${i.toString().padLeft(3, '0')}.ttf';
    final fullPath = p.join(dir.path, fileName);

    try {
      log('İndiriliyor: $fileName...');
      await dio.download(
        url,
        fullPath,
        onReceiveProgress: (received, total) {},
      );
    } on Object catch (e) {
      log('Hata oluştu ($fileName): $e');
      continue;
    }
  }

  log('İşlem tamamlandı! Dosyalar $currentProjectPath klasöründe.');
}

void main() async {
  await downloadQuranFontsTtfFont();
}

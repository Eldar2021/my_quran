import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

// Future<void> downloadQuranNormalFont() async {
//   final dio = Dio();

//   final currentProjectPath = '${Directory.current.path}/quran_data/normal_fonts/';

//   final dir = Directory(currentProjectPath);

//   if (!dir.existsSync()) {
//     await dir.create(recursive: true);
//   }

//   log('İndirme işlemi başlıyor...');

//   for (var i = 1; i <= 604; i++) {
//     final url = 'https://quran.com/fonts/quran/hafs/v2/woff2/p$i.woff2';

//     final fileName = '${i.toString().padLeft(3, '0')}.woff2';
//     final fullPath = p.join(dir.path, fileName);

//     try {
//       log('İndiriliyor: $fileName...');
//       await dio.download(
//         url,
//         fullPath,
//         onReceiveProgress: (received, total) {},
//       );
//     } on Object catch (e) {
//       log('Hata oluştu ($fileName): $e');
//       continue;
//     }
//   }

//   log('İşlem tamamlandı! Dosyalar $currentProjectPath klasöründe.');
// }

void main() async {
  await downloadQuranTajweedFont();
  // await downloadQuranNormalFont();
}

Future<void> downloadQuranTajweedFont() async {
  final dio = Dio();

  final currentProjectPath = '${Directory.current.path}/quran_data/tajweed_fonts/';

  final dir = Directory(currentProjectPath);

  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }

  log('İndirme işlemi başlıyor...');

  for (var i = 1; i <= 604; i++) {
    final url = 'https://quran.com/fonts/quran/hafs/v4/colrv1/woff2/p$i.woff2';

    final fileName = '${i.toString().padLeft(3, '0')}.woff2';
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

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

// https://api-docs.quran.foundation/docs/tutorials/fonts/font-rendering

const _token = '..';

const JsonEncoder encoder = JsonEncoder.withIndent('  ');

Future<void> main() async {
  await getQuranByPages();
}

Future<void> getQuranByPages() async {
  final dio = Dio();

  final currentProjectPath = p.join(Directory.current.path, 'quran_data', 'quran_pages');
  final dir = Directory(currentProjectPath);

  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }

  for (var i = 1; i <= 604; i++) {
    final fileName = '${i.toString().padLeft(3, '0')}.json';
    final filePath = p.join(dir.path, fileName);

    try {
      log('Downloading page $i...');
      final response = await dio.get<Map<String, dynamic>>(
        'https://apis-prelive.quran.foundation/content/api/v4/quran/verses/code_v2?page_number=$i',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'x-auth-token': _token,
            'x-client-id': '89de0e22-e43f-4f39-8fe8-6d6aee6ca438',
          },
        ),
      );

      if (response.data != null) {
        final file = File(filePath);
        await file.writeAsString(encoder.convert(response.data));
        log('Saved: $fileName');
      }
    } on Object catch (e) {
      log('Error downloading page $i: $e');
    }
  }
  log('Tüm sayfalar indirildi.');
}

// Future<void> getQuranByJuz() async {
//   final dio = Dio();

//   final currentProjectPath = p.join(Directory.current.path, 'quran_data', 'quran_juzs');
//   final dir = Directory(currentProjectPath);

//   if (!dir.existsSync()) {
//     await dir.create(recursive: true);
//   }

//   for (var i = 1; i <= 30; i++) {
//     final fileName = '${i.toString().padLeft(2, '0')}.json';
//     final filePath = p.join(dir.path, fileName);

//     try {
//       log('Downloading juz $i...');
//       final response = await dio.get<Map<String, dynamic>>(
//         'https://apis-prelive.quran.foundation/content/api/v4/quran/verses/code_v2?juz_number=$i',
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'x-auth-token': _token,
//             'x-client-id': '89de0e22-e43f-4f39-8fe8-6d6aee6ca438',
//           },
//         ),
//       );

//       if (response.data != null) {
//         final file = File(filePath);
//         await file.writeAsString(encoder.convert(response.data));
//         log('Saved: $fileName');
//       }
//     } on Object catch (e) {
//       log('Error downloading juz $i: $e');
//     }
//   }
//   log('Tüm cüzler indirildi.');
// }

// Future<void> getQuranBySurahs() async {
//   final dio = Dio();

//   final currentProjectPath = p.join(Directory.current.path, 'quran_data', 'quran_surahs');
//   final dir = Directory(currentProjectPath);

//   if (!dir.existsSync()) {
//     await dir.create(recursive: true);
//   }

//   for (var i = 1; i <= 114; i++) {
//     final fileName = '${i.toString().padLeft(3, '0')}.json';
//     final filePath = p.join(dir.path, fileName);

//     try {
//       log('Downloading surah $i...');
//       final response = await dio.get<Map<String, dynamic>>(
//         'https://apis-prelive.quran.foundation/content/api/v4/quran/verses/code_v2?chapter_number=$i',
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'x-auth-token': _token,
//             'x-client-id': '89de0e22-e43f-4f39-8fe8-6d6aee6ca438',
//           },
//         ),
//       );

//       if (response.data != null) {
//         final file = File(filePath);
//         await file.writeAsString(encoder.convert(response.data));
//         log('Saved: $fileName');
//       }
//     } on Object catch (e) {
//       log('Error downloading surah $i: $e');
//     }
//   }
//   log('Tüm sureler indirildi.');
// }

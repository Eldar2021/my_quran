import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

const _token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjI5M2JiNjhkLWU0NGQtNDJhZi04MThjLTc5MjQ3MzUzYjZmMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOltdLCJjbGllbnRfaWQiOiI4OWRlMGUyMi1lNDNmLTRmMzktOGZlOC02ZDZhZWU2Y2E0MzgiLCJleHAiOjE3NzA4MzEwOTUsImV4dCI6e30sImlhdCI6MTc3MDgyNzQ5NSwiaXNzIjoiaHR0cHM6Ly9wcmVsaXZlLW9hdXRoMi5xdXJhbi5mb3VuZGF0aW9uIiwianRpIjoiZmEyYTEyYWQtNTQ4YS00OWNiLWI4NDMtYTM1OWVmMmNkMzQzIiwibmJmIjoxNzcwODI3NDk1LCJzY3AiOlsiY29udGVudCJdLCJzdWIiOiI4OWRlMGUyMi1lNDNmLTRmMzktOGZlOC02ZDZhZWU2Y2E0MzgifQ.OVC3D9frJzEnrKoc4MDNagvaGnDZ96WC4ybi1i1dJEV77eVL2ygaSEGTc06pH2K1_iNJIZ3KN2REjQ9TNR7qdPXhPe-HFK4OAcsBSPkQG5n8gPk4u9Fia8kqsNEk54Mf8iUPXwctwJnNbSPGJXhjNyCjM3MYCJbKB4oWsmKNo9tRNuVeCIQnhXAkSYV1ZJasd750IVxa0j2o3Oua_nUwA4SB-xA5Iy-fk31eKq9wgAOgzqCXHGVoWF8GCsALVRLXreDIvHff4gYTTdhoWefAYbOsnqRcqSLhBJtMK3CYAiESnyGi-IraCWJ7AzgyzLx7tMObxNdRYQ6y0oLtPWYE3B3PDCXRDHXkF5nRhf0iEmPa0_JIg1pwXZDtaenMZmYQN1FvyyuJLp--9F6wuobKZ7c1mevIaSVOVL9Tfn_GNMOVQE-hSIPsmr1ZMdNZfvrLA3NGRgMCqR05KXlKhtWeznPy_1nWlNbA6pyRXg6nZu0S91juhkBCVaCGiVXU8WFQJSfy2G4THjaUXtJfZPrXf8T5lrXg01cGzMuUFImfJjOTWK6FqvZZeTYy7UOoAoltkeMxxutirsct-ueChY9gcWK9gOPkf-3DLkmtK3PLE2v_roFhgoJD_1f0giQsnBfhW5S1G3lazcuSwGbGAvxQOol1_6p_Bxj2zIHxNulzwIQ';

const JsonEncoder encoder = JsonEncoder.withIndent('  ');

Future<void> main() async {
  await getQuranBySurahs();
}

Future<void> getQuranBySurahs() async {
  final dio = Dio();

  final currentProjectPath = p.join(Directory.current.path, 'quran_data', 'quran_surahs');
  final dir = Directory(currentProjectPath);

  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }

  for (var i = 1; i <= 114; i++) {
    final fileName = '${i.toString().padLeft(3, '0')}.json';
    final filePath = p.join(dir.path, fileName);

    try {
      log('Downloading surah $i...');
      final response = await dio.get<Map<String, dynamic>>(
        'https://apis-prelive.quran.foundation/content/api/v4/quran/verses/code_v2?chapter_number=$i',
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
      log('Error downloading surah $i: $e');
    }
  }
  log('Tüm sureler indirildi.');
}

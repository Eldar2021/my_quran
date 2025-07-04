import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';

@immutable
final class ParseParams {
  const ParseParams._();

  static List<int> parseRead(Map<String, String> args) {
    try {
      final p1 = args['pages'] ?? '[1]';
      final pages = p1.substring(1, p1.length - 1).split(',').map(int.parse).toList();
      return pages;
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log(e.toString());
      return [1];
    }
  }

  static int parseSurahNumber(Map<String, String> args) {
    try {
      return int.parse(args['surahNumber'] ?? '1');
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      return 1;
    }
  }

  static int parseJuzNumber(Map<String, String> args) {
    try {
      return int.parse(args['juzNumber'] ?? '1');
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      return 1;
    }
  }

  static String parseHatimId(Map<String, String> args) {
    try {
      return args['hatimId'] ?? '';
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      return '';
    }
  }
}

import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';

@immutable
final class ParseParams {
  const ParseParams._();

  static (List<int>, bool) parseRead(Map<String, String> args) {
    try {
      final isHatim = args['isHatim'] == 'true';
      final p1 = args['pages'] ?? '[1]';
      final pages = p1.substring(1, p1.length - 1).split(',').map(int.parse).toList();
      return (pages, isHatim);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log(e.toString());
      return ([1], false);
    }
  }

  static int parseSurahNumber(Map<String, String> args) {
    try {
      return int.parse(args['surahNumber'] ?? '1');
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return 1;
    }
  }
}

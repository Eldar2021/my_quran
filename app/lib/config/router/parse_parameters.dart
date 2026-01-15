import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ParseParams {
  const ParseParams._();

  static (List<int>, String?) parseRead(Map<String, String> args) {
    try {
      final p1 = args['pages'] ?? '[1]';
      final pages = p1.substring(1, p1.length - 1).split(',').map(int.parse).toList();
      final hatimId = args['hatimId'];
      return (pages, hatimId);
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log(e.toString());
      return ([1], null);
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

  static HatimViewParams parseHatimId(Map<String, String> args) {
    try {
      final hatimId = args['hatimId'] ?? '';
      final isCreator = args['isCreator'] ?? 'false';
      return HatimViewParams(
        hatimId: hatimId,
        isCreator: bool.tryParse(isCreator) ?? false,
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      return const HatimViewParams(hatimId: '');
    }
  }

  static String? parseHatimCrud(Map<String, dynamic> args) {
    try {
      final hatimId = args['hatimId'] as String?;
      return hatimId;
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      return null;
    }
  }
}

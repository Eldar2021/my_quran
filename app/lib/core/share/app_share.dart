import 'dart:developer';
import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class AppShare {
  const AppShare._();

  static Future<void> share(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }

  static Future<void> shareUri(
    String url, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      await Share.shareUri(
        Uri.parse(url),
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }

  static Future<void> shareXFiles(
    List<XFile> files, {
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
    List<String>? fileNameOverrides,
  }) async {
    try {
      await Share.shareXFiles(
        files,
        subject: subject,
        text: text,
        sharePositionOrigin: sharePositionOrigin,
        fileNameOverrides: fileNameOverrides,
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }
}

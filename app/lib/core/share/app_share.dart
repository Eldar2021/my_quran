import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class AppShare {
  const AppShare._();

  static Future<void> share({
    required BuildContext context,
    required String text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }

  static Future<void> shareUri({
    required BuildContext context,
    required String url,
    Rect? sharePositionOrigin,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    try {
      await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse(url),
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }

  static Future<void> shareXFiles({
    required BuildContext context,
    required List<XFile> files,
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
    List<String>? fileNameOverrides,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: files,
          subject: subject,
          text: text,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          fileNameOverrides: fileNameOverrides,
        ),
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log('share error: $e, \n launch stack-trace: $s');
    }
  }
}

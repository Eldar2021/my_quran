// Ignored print
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

extension ScreenshotExtension on FlutterDriver {
  Future<void> takeScreenshot(
    String name, {
    String directory = '../screenshots',
    bool waitUntilNoTransientCallbacks = true,
  }) async {
    if (waitUntilNoTransientCallbacks) {
      await this.waitUntilNoTransientCallbacks(
        timeout: const Duration(seconds: 30),
      );
    }
    try {
      final pixels = await screenshot().timeout(const Duration(minutes: 2));
      final directoryPath = directory.endsWith('/') ? directory : '$directory/';
      final file = await File('$directoryPath$name.png').create(recursive: true);
      await file.writeAsBytes(pixels);
    } on Object catch (e) {
      print(e);
    }
    print('Screenshot $name');
  }
}

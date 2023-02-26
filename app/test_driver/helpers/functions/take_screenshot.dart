import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

Future<void> takeScreenshot(
  FlutterDriver driver,
  String name, {
  Duration timeout = const Duration(seconds: 30),
  bool silent = false,
  bool waitUntilNoTransientCallbacks = true,
}) async {
  if (waitUntilNoTransientCallbacks) {
    await driver.waitUntilNoTransientCallbacks(timeout: timeout);
  }

  final pixels = await driver.screenshot();
  final file = await File('screenshots/$name.png').create(recursive: true);
  await file.writeAsBytes(pixels);
  // ignore: avoid_print
  print('Screenshot $name created ================> ${file.path}');
}

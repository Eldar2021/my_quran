import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:hatim/main.dart' as app;

// flutter drive --target=test_driver/app.dart

Future<void> main() async {
  enableFlutterDriverExtension(
    handler: (command) {
      var result = '';
      switch (command) {
        case 'getPlatformCommand':
          result = Platform.operatingSystem;
          break;
      }
      return Future.value(result);
    },
  );
  await app.main();
}

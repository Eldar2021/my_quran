import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/main.dart' as app;

// flutter drive --target=test_driver/app.dart

// flutter drive --target=test_driver/app.dart -d web-server --release --browser-name=chrome --web-port=8080
// flutter drive --driver=test_driver/app.dart -d web-server --release --browser-name=safari --web-port=8080

Future<void> main() async {
  enableFlutterDriverExtension(
    handler: (command) {
      var result = '';
      switch (command) {
        case 'getPlatformCommand':
          result = Platform.operatingSystem;
      }
      return Future.value(result);
    },
  );
  await app.main(appConfig: const AppConfig(isIntegrationTest: true));
}

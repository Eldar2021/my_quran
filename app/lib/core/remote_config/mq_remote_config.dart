import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class MqRemoteConfig {
  const MqRemoteConfig._();

  static Future<void> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setDefaults(<String, dynamic>{
        'version': '1.3.1',
        'build_number': 10,
        'update_required': false,
      });
      await remoteConfig.fetchAndActivate();

      _listenForUpdates(remoteConfig);
    } catch (error, stackTrace) {
      MqCrashlytics.report(error, stackTrace);
      log('MqRemoteConfig initialize error: $error, stackTrace: $stackTrace');
    }
  }

  static String get latestVersion => FirebaseRemoteConfig.instance.getString('version');
  static int get buildNumber => FirebaseRemoteConfig.instance.getInt('build_number');
  static bool get updateRequired => FirebaseRemoteConfig.instance.getBool('update_required');

  static void _listenForUpdates(FirebaseRemoteConfig remoteConfig) {
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      log('MqRemoteConfig: Config updated and activated');
    });
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MqRemoteConfig {
  const MqRemoteConfig({
    required this.remoteConfig,
    required this.buildNumber,
  });

  final FirebaseRemoteConfig remoteConfig;
  final String buildNumber;

  Future<void> initialise() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.setDefaults(_defaultParams(currentBuildNumber));
    await remoteConfig.fetchAndActivate();
  }

  int get currentBuildNumber => int.tryParse(buildNumber) ?? 100;
  int get requiredBuildNumber => version.$1;
  int get recommendedBuildNumber => version.$2;

  (int, int) get version {
    final data = jsonDecode(remoteConfig.getString(_appVersion)) as Map<String, dynamic>;
    final platformName = Platform.isIOS ? 'ios' : 'android';
    final versionData = data[platformName] as Map<String, dynamic>;
    return (versionData['requiredBuildNumber'], versionData['recommendedBuildNumber']);
  }

  static const _enableHatim = 'enableHatim';
  static const _appVersion = 'appVersion';

  static Map<String, dynamic> _defaultAppVersionValue(int currentBuildNumber) {
    return {
      'android': {
        'requiredBuildNumber': currentBuildNumber,
        'recommendedBuildNumber': currentBuildNumber,
      },
      'ios': {
        'requiredBuildNumber': currentBuildNumber,
        'recommendedBuildNumber': currentBuildNumber,
      },
    };
  }

  static Map<String, dynamic> _defaultParams(int currentBuildNumber) {
    return {
      _enableHatim: true,
      _appVersion: jsonEncode(_defaultAppVersionValue(currentBuildNumber)),
    };
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

@immutable
class MqRemoteConfig {
  MqRemoteConfig({
    required this.buildNumber,
    FirebaseRemoteConfig? firebaseRemoteConfig,
  }) : _firebaseRemoteConfig = firebaseRemoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _firebaseRemoteConfig;
  final String buildNumber;

  Future<void> initialise() async {
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await _firebaseRemoteConfig.setDefaults(_defaultParams(currentBuildNumber));
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  int get currentBuildNumber => int.tryParse(buildNumber) ?? 100;
  int get requiredBuildNumber => version.$1;
  int get recommendedBuildNumber => version.$2;

  (int, int) get version {
    final data = jsonDecode(_firebaseRemoteConfig.getString(_appVersion)) as Map<String, dynamic>;
    final platformName = Platform.isIOS ? 'ios' : 'android';
    final versionData = data[platformName] as Map<String, dynamic>;
    return (versionData['requiredBuildNumber'], versionData['recommendedBuildNumber']);
  }

  static const _hatimIsEnable = 'hatimIsEnable';
  static const _donationIsEnable = 'donationIsEnable';
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
      _hatimIsEnable: true,
      _donationIsEnable: false,
      _appVersion: jsonEncode(_defaultAppVersionValue(currentBuildNumber)),
    };
  }

  bool get hatimIsEnable => _firebaseRemoteConfig.getBool(_hatimIsEnable);

  bool get donaitonIsEnable => _firebaseRemoteConfig.getBool(_donationIsEnable);

  StreamSubscription<void> listen(
    void Function() onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _firebaseRemoteConfig.onConfigUpdated.listen(
      (data) async {
        await _firebaseRemoteConfig.activate();
        onData();
      },
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

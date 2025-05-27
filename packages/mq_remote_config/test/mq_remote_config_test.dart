import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_remote_config/mq_remote_config.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class MockPackageInfo extends Mock implements PackageInfo {}

void main() {
  late MockFirebaseRemoteConfig mockFirebaseRemoteConfig;
  late MockPackageInfo mockPackageInfo;
  late MqRemoteConfig mqRemoteConfig;

  setUp(() {
    mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();
    mockPackageInfo = MockPackageInfo();

    when(() => mockPackageInfo.version).thenReturn('1.0.0');
    when(() => mockPackageInfo.buildNumber).thenReturn('101');

    mqRemoteConfig = MqRemoteConfig(packageInfo: mockPackageInfo, firebaseRemoteConfig: mockFirebaseRemoteConfig);

    when(() => mockFirebaseRemoteConfig.setConfigSettings(any())).thenAnswer((_) async {});
    when(() => mockFirebaseRemoteConfig.setDefaults(any())).thenAnswer((_) async {});
    when(() => mockFirebaseRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);
    when(() => mockFirebaseRemoteConfig.activate()).thenAnswer((_) async => true);

    when(() => mockFirebaseRemoteConfig.onConfigUpdated).thenAnswer((_) => const Stream.empty());
  });

  setUpAll(() {
    registerFallbackValue(
      RemoteConfigSettings(fetchTimeout: const Duration(minutes: 1), minimumFetchInterval: const Duration(hours: 1)),
    );
    registerFallbackValue(<String, dynamic>{});
  });

  group('MqRemoteConfig Tests with Mocktail', () {
    test('initialise should call FirebaseRemoteConfig methods', () async {
      await mqRemoteConfig.initialise();

      verify(() => mockFirebaseRemoteConfig.setConfigSettings(any())).called(1);

      final expectedDefaults = {
        'hatimIsEnable': true,
        'donationIsEnable': false,
        'appVersion': jsonEncode({
          'android': {'requiredBuildNumber': 101, 'recommendedBuildNumber': 101},
          'ios': {'requiredBuildNumber': 101, 'recommendedBuildNumber': 101},
        }),
      };
      verify(() => mockFirebaseRemoteConfig.setDefaults(expectedDefaults)).called(1);

      verify(() => mockFirebaseRemoteConfig.fetchAndActivate()).called(1);
    });

    test('currentBuildNumber should return correct build number', () {
      when(() => mockPackageInfo.buildNumber).thenReturn('250');
      expect(mqRemoteConfig.currentBuildNumber, 250);
    });

    test('currentBuildNumber should return default value for invalid build number', () {
      when(() => mockPackageInfo.buildNumber).thenReturn('invalid');
      expect(mqRemoteConfig.currentBuildNumber, 100);
    });

    test('version should parse version data correctly for android', () {
      final mockVersionJson = {
        'android': {'requiredBuildNumber': 10, 'recommendedBuildNumber': 15},
        'ios': {'requiredBuildNumber': 12, 'recommendedBuildNumber': 18},
      };
      when(() => mockFirebaseRemoteConfig.getString('appVersion')).thenReturn(jsonEncode(mockVersionJson));

      final versionTuple = mqRemoteConfig.version;
      expect(versionTuple.$1, 10);
      expect(versionTuple.$2, 15);
      expect(mqRemoteConfig.requiredBuildNumber, 10);
      expect(mqRemoteConfig.recommendedBuildNumber, 15);
    });

    test('hatimIsEnable should return correct value from Firebase', () {
      when(() => mockFirebaseRemoteConfig.getBool('hatimIsEnable')).thenReturn(true);
      expect(mqRemoteConfig.hatimIsEnable, isTrue);

      when(() => mockFirebaseRemoteConfig.getBool('hatimIsEnable')).thenReturn(false);
      expect(mqRemoteConfig.hatimIsEnable, isFalse);
    });

    test('donaitonIsEnable should return correct value from Firebase', () {
      when(() => mockFirebaseRemoteConfig.getBool('donationIsEnable')).thenReturn(false);
      expect(mqRemoteConfig.donaitonIsEnable, isFalse);

      when(() => mockFirebaseRemoteConfig.getBool('donationIsEnable')).thenReturn(true);
      expect(mqRemoteConfig.donaitonIsEnable, isTrue);
    });

    test('appVersion should return correct version from PackageInfo', () {
      when(() => mockPackageInfo.version).thenReturn('1.2.3');
      expect(mqRemoteConfig.appVersion, '1.2.3');
    });

    test('buildBumber should return correct build number from PackageInfo', () {
      when(() => mockPackageInfo.buildNumber).thenReturn('789');
      expect(mqRemoteConfig.buildBumber, '789');
    });

    test('listen should subscribe to onConfigUpdated and call activate and onData', () async {
      final controller = StreamController<RemoteConfigUpdate>();
      when(() => mockFirebaseRemoteConfig.onConfigUpdated).thenAnswer((_) => controller.stream);

      var onDataCalled = false;
      void testOnData() {
        onDataCalled = true;
      }

      final subscription = mqRemoteConfig.listen(testOnData);

      controller.add(RemoteConfigUpdate({}));

      await Future<void>.delayed(Duration.zero);

      verify(() => mockFirebaseRemoteConfig.activate()).called(1);
      expect(onDataCalled, isTrue);

      await controller.close();
      await subscription.cancel();
    });

    test('defaultParams should generate correct default parameters', () {
      final params = MqRemoteConfig.defaultParams(123);

      expect(params['hatimIsEnable'], isTrue);
      expect(params['donationIsEnable'], isFalse);

      final appVersionDecoded = jsonDecode(params['appVersion'] as String) as Map<String, dynamic>;
      final androidVersion = appVersionDecoded['android'] as Map<String, dynamic>;
      final iosVersion = appVersionDecoded['ios'] as Map<String, dynamic>;

      expect(androidVersion['requiredBuildNumber'], 123);
      expect(androidVersion['recommendedBuildNumber'], 123);
      expect(iosVersion['requiredBuildNumber'], 123);
      expect(iosVersion['recommendedBuildNumber'], 123);
    });

    test('defaultAppVersionValue should generate correct version map', () {
      final versionValue = MqRemoteConfig.defaultAppVersionValue(456);

      final androidVersion = versionValue['android'] as Map<String, dynamic>;
      final iosVersion = versionValue['ios'] as Map<String, dynamic>;

      expect(androidVersion['requiredBuildNumber'], 456);
      expect(androidVersion['recommendedBuildNumber'], 456);
      expect(iosVersion['requiredBuildNumber'], 456);
      expect(iosVersion['recommendedBuildNumber'], 456);
    });
  });
}

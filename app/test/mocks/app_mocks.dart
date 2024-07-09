import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

final class MockPreferencesStorage extends Mock implements PreferencesStorage {}

final class MockRemoteClient extends Mock implements RemoteClient {}

final class MockSccialAuth extends Mock implements SoccialAuth {}

final class MockPackageInfo extends Mock implements PackageInfo {
  @override
  String get version => '1.3.0';

  @override
  String get buildNumber => '10';
}

final class MockHomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeEntity> getData(String token) async {
    return const HomeEntity(allDoneHatims: 8, allDonePages: 5325, donePages: 634);
  }
}

final class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {
  @override
  Stream<RemoteConfigUpdate> get onConfigUpdated {
    return const Stream.empty();
  }
}

class MockMqRemoteConfig implements MqRemoteConfig {
  @override
  String get buildNumber => '1.3.0';

  @override
  int get currentBuildNumber => 10;

  @override
  Future<void> initialise() async {}

  @override
  bool get hatimIsEnable => false;

  @override
  int get recommendedBuildNumber => 10;

  @override
  int get requiredBuildNumber => 10;

  @override
  (int, int) get version => (10, 10);

  @override
  FirebaseRemoteConfig get remoteConfig => MockFirebaseRemoteConfig();
}

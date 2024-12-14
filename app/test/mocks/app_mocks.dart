import 'dart:async';

import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_remote_config/mq_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

final class MockPreferencesStorage extends Mock implements PreferencesStorage {}

final class MockRemoteClient extends Mock implements MqRemoteClient {}

final class MockSccialAuth extends Mock implements SoccialAuth {}

final class MockPackageInfo extends Mock implements PackageInfo {
  @override
  String get version => '1.3.0';

  @override
  String get buildNumber => '10';
}

final class MockHomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeEntity> getData() async {
    return const HomeEntity(allDoneHatims: 8, allDonePages: 5325, donePages: 634);
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
  StreamSubscription<void> listen(
    void Function() onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream.value('').listen(
      (i) => onData(),
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

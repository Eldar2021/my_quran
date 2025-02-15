import 'dart:async';

import 'package:mq_remote_config/mq_remote_config.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:mocktail/mocktail.dart';

final class MockStorage extends Mock implements PreferencesStorage {
  MockStorage();

  @override
  String? readString({required String key}) {
    return null;
  }

  @override
  bool? readBool({required String key}) {
    return null;
  }

  @override
  double? readDouble({required String key}) {
    return null;
  }

  @override
  int? readInt({required String key}) {
    return null;
  }

  @override
  List<String>? readStringList({required String key}) {
    return null;
  }

  @override
  Future<bool> writeString({required String key, required String value}) {
    return Future.value(true);
  }

  @override
  Future<bool> writeBool({required String key, required bool value}) {
    return Future.value(true);
  }

  @override
  Future<bool> writeDouble({required String key, required double value}) {
    return Future.value(true);
  }

  @override
  Future<bool> writeInt({required String key, required int value}) {
    return Future.value(true);
  }

  @override
  Future<bool> writeStringList({required String key, required List<String> value}) {
    return Future.value(true);
  }

  @override
  Future<bool> delete({required String key}) async {
    return Future.value(true);
  }

  @override
  Future<bool> clear() {
    return Future.value(true);
  }
}

class MockMqRemoteConfig implements MqRemoteConfig {
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
    return Stream.value('').listen((i) => onData(), onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  bool get donaitonIsEnable => false;

  @override
  String get appVersion => '1.3.0';

  @override
  String get buildBumber => '10';
}

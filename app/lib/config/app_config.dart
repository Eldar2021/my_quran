import 'package:flutter/foundation.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';

@immutable
final class AppConfig {
  const AppConfig({
    this.storage,
    this.isIntegrationTest = false,
  });

  final bool isIntegrationTest;

  final PreferencesStorage? storage;

  Future<void> setDevMode({required String devDomain, required bool isDevmode}) async {
    await storage?.writeString(key: 'dev-domain', value: devDomain);
    await storage?.writeBool(key: 'dev-mode', value: isDevmode);
  }

  Future<void> clearDevMode() async {
    await storage?.delete(key: 'dev-domain');
    await storage?.delete(key: 'dev-mode');
  }

  Future<void> changeJustDevMode({required bool isDevmode}) async {
    await storage?.writeBool(key: 'dev-mode', value: isDevmode);
    init();
  }

  void init() {
    final devDomain = storage?.readString(key: 'dev-domain');
    final isDevmode = storage?.readBool(key: 'dev-mode') ?? false;
    apiConst = ApiConst(isDevmode: isDevmode, devDomain: devDomain);
  }
}

ApiConst apiConst = const ApiConst(isDevmode: false);

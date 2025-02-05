import 'package:flutter/foundation.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AppConfig {
  const AppConfig({
    required this.storage,
    this.isIntegrationTest = false,
    this.isMockData = false,
  });

  final bool isIntegrationTest;
  final bool isMockData;

  final PreferencesStorage storage;

  Future<void> setDevMode({required String devDomain, required bool isDevmode}) async {
    await storage.writeString(key: 'dev-domain', value: devDomain);
    await storage.writeBool(key: 'dev-mode', value: isDevmode);

    await Future.wait<bool>([
      storage.writeString(key: 'dev-domain', value: devDomain),
      storage.writeBool(key: 'dev-mode', value: isDevmode),
    ]);
  }

  Future<void> clearDevMode() async {
    await Future.wait([
      storage.delete(key: 'dev-domain'),
      storage.delete(key: 'dev-mode'),
    ]);
  }

  Future<void> changeJustDevMode({required bool isDevmode}) async {
    await storage.writeBool(key: 'dev-mode', value: isDevmode);
  }

  bool get isDevMode {
    return storage.readBool(key: 'dev-mode') ?? false;
  }

  String get devDomain {
    return storage.readString(key: 'dev-domain') ?? '';
  }
}

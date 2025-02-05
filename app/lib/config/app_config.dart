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
    await storage.clear();
    await Future.wait<bool>([
      storage.writeString(key: 'dev-domain', value: devDomain),
      storage.writeBool(key: 'dev-mode', value: isDevmode),
    ]);
  }

  bool get isDevMode {
    return storage.readBool(key: 'dev-mode') ?? false;
  }

  String get devDomain {
    return storage.readString(key: 'dev-domain') ?? '';
  }
}

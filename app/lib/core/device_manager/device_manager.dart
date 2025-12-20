import 'dart:developer';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:uuid/uuid.dart';

@immutable
final class DeviceManager {
  const DeviceManager({
    required this.secureStorage,
    required this.uuid,
  });

  final SecureStorage secureStorage;
  final Uuid uuid;

  static const _keyDeviceId = 'unique_device_id';

  Future<String> getDeviceId() async {
    try {
      final deviceId = await secureStorage.read(_keyDeviceId);
      if (deviceId != null && deviceId.isNotEmpty) {
        log('✅ Cached deviceId: $deviceId');
        return deviceId;
      }
      final generatedId = uuid.v4();
      await secureStorage.write(
        key: _keyDeviceId,
        value: generatedId,
      );
      log('✅ Generated deviceId: $generatedId');
      return generatedId;
    } on Object catch (e) {
      log('❌ DeviceIdManager getDeviceId:', error: e);
      await secureStorage.delete(_keyDeviceId);
      final newId = uuid.v4();
      log('✅ Generated deviceId: $newId');
      await secureStorage.write(key: _keyDeviceId, value: newId);
      return newId;
    }
  }

  Future<String> getDeviceTimezone() async {
    try {
      final deviceTimezone = await FlutterTimezone.getLocalTimezone();
      log('✅ DeviceTimezone: $deviceTimezone');
      return deviceTimezone.identifier;
    } on Object catch (e) {
      log('❌ DeviceIdManager getDeviceTimezone:', error: e);
      return 'UTC';
    }
  }
}

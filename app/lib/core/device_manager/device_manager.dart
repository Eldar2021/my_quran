import 'dart:developer';

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
      if (deviceId != null && deviceId.isNotEmpty) return deviceId;
      final generatedId = uuid.v4();
      await secureStorage.write(
        key: _keyDeviceId,
        value: generatedId,
      );
      return generatedId;
    } on Object catch (e) {
      log('DeviceIdManager getDeviceId:', error: e);
      await secureStorage.delete(_keyDeviceId);
      final newId = uuid.v4();
      await secureStorage.write(key: _keyDeviceId, value: newId);
      return newId;
    }
  }
}

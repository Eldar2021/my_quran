import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqLocationStorageImpl implements MqLocationStorage {
  const MqLocationStorageImpl(this.storage);

  final PreferencesStorage storage;

  static const _locationKey = 'location';
  static const _locationNameKey = 'location-name';
  static const _timeZoneLocationKey = 'time-zone-location';

  @override
  Position? getCashedLocation() {
    final location = storage.readString(key: _locationKey);
    if (location == null) return null;
    final value = jsonDecode(location) as Map<String, dynamic>;
    final data = LocationJson.fromJson(value);
    return data.toLocation();
  }

  @override
  String? getLocationName() {
    return storage.readString(key: _locationNameKey);
  }

  @override
  Future<void> setLocation(Position position) async {
    final data = LocationJson.fromPosition(position);
    final value = jsonEncode(data.toJson());
    await storage.writeString(key: _locationKey, value: value);
  }

  @override
  Future<void> setLocationName(String locationName) async {
    await storage.writeString(key: _locationNameKey, value: locationName);
  }

  @override
  String? getTimeZoneLocation() {
    return storage.readString(key: _timeZoneLocationKey);
  }

  @override
  Future<void> setTimeZoneLocation(String timeZoneLocation) async {
    await storage.writeString(key: _timeZoneLocationKey, value: timeZoneLocation);
  }
}

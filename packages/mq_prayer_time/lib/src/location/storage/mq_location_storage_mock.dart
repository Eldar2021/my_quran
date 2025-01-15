import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationStorageMock implements MqLocationStorage {
  const MqLocationStorageMock();

  @override
  Position? getCashedLocation() {
    return MqLocationStatic.makkahPosition;
  }

  @override
  String? getLocationName() {
    return MqLocationStatic.makkahName;
  }

  @override
  Future<void> setLocation(Position position) {
    return Future.value();
  }

  @override
  Future<void> setLocationName(String locationName) {
    return Future.value();
  }
}

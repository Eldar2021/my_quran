import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationStorageMock implements MqLocationStorage {
  const MqLocationStorageMock();

  @override
  Position? getCashedLocation() {
    return Position(
      latitude: 21.422510,
      longitude: 39.826168,
      timestamp: DateTime.now(),
      altitudeAccuracy: 0,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  @override
  String? getLocationName() {
    return 'Makkah';
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

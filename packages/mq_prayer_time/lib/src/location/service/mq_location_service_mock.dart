import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationServiceMock implements MqLocationService {
  const MqLocationServiceMock();

  @override
  Future<Position> getCurrentLocation() async {
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
  Future<String> getLocationName(Position position) async {
    return Future.value('Makkah');
  }

  @override
  Future<bool> getLocationPermission() {
    return Future.value(true);
  }
}

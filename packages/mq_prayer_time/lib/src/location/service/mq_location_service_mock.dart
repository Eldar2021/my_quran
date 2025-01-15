import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationServiceMock implements MqLocationService {
  const MqLocationServiceMock();

  @override
  Future<Position> getCurrentLocation() async {
    return MqLocationStatic.makkahPosition;
  }

  @override
  Future<String> getLocationName(Position position) async {
    return Future.value(MqLocationStatic.makkahName);
  }

  @override
  Future<bool> getLocationPermission() {
    return Future.value(true);
  }
}

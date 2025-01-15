import 'package:flutter/material.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationMockService implements MqLocationService {
  const MqLocationMockService();

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

  @override
  Future<String> timeZoneLocation() {
    return Future.value(MqLocationStatic.makkahTimezone);
  }
}

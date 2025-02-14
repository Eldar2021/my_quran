import 'package:flutter/material.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationClient {
  const MqLocationClient({required this.locationService, required this.locationStorage});

  final MqLocationService locationService;
  final MqLocationStorage locationStorage;

  Position get initialPosition {
    final position = locationStorage.getCashedLocation();
    return position ?? MqLocationStatic.makkahPosition;
  }

  String get initialLocationName {
    final name = locationStorage.getLocationName();
    return name ?? MqLocationStatic.makkahName;
  }

  String get initialTimeZoneLocation {
    final name = locationStorage.getTimeZoneLocation();
    return name ?? MqLocationStatic.makkahTimezone;
  }

  Future<void> init({
    required void Function(Position position, String locationName, String timeZoneLocation) onInitailLocation,
    required void Function(Position position, String locationName, String timeZoneLocation) onKeepLocation,
    required void Function(Position position, String locationName, String timeZoneLocation) onNewLocation,
  }) async {
    final position = await locationService.getCurrentLocation();
    final cashedPosition = locationStorage.getCashedLocation();
    if (position.latitude != cashedPosition?.latitude &&
        position.longitude != cashedPosition?.longitude &&
        position.latitude != MqLocationStatic.makkahPosition.latitude &&
        position.longitude != MqLocationStatic.makkahPosition.longitude) {
      final locationName = await locationService.getLocationName(position);
      final timeZoneLocation = await locationService.timeZoneLocation();
      final cachedLocationName = locationStorage.getLocationName();
      if (cashedPosition == null) {
        onInitailLocation(position, locationName, timeZoneLocation);
      } else {
        if (locationName != cachedLocationName) {
          onNewLocation(position, locationName, timeZoneLocation);
        }
      }
    } else {
      final locationName = await locationService.getLocationName(position);
      final timeZoneLocation = await locationService.timeZoneLocation();
      onKeepLocation(position, locationName, timeZoneLocation);
    }
  }

  Future<void> saveData({required Position position, required String locationName, required String timeZoneLocation}) {
    return Future.wait([
      locationStorage.setLocation(position),
      locationStorage.setLocationName(locationName),
      locationStorage.setTimeZoneLocation(timeZoneLocation),
    ]);
  }
}

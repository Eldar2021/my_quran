import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@immutable
final class MqLocationServiceImpl implements MqLocationService {
  const MqLocationServiceImpl();

  @override
  Future<Position> getCurrentLocation() async {
    try {
      final permission = await getLocationPermission();
      if (permission) {
        final location = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        return location;
      } else {
        return MqLocationStatic.makkahPosition;
      }
    } catch (e, s) {
      log('getCurrentLocation error: $e \n $s');
      return MqLocationStatic.makkahPosition;
    }
  }

  @override
  Future<bool> getLocationPermission() async {
    try {
      final currentPermission = await Geolocator.checkPermission();
      if (currentPermission == LocationPermission.denied) {
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return false;
        if (permission == LocationPermission.deniedForever) return false;
        return true;
      } else if (currentPermission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } catch (e, s) {
      log('_getLocationPermission error: $e \n $s');
      return false;
    }
  }

  @override
  Future<String> getLocationName(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = place.subAdministrativeArea;
        final district = place.administrativeArea;
        if (city != null && city.isNotEmpty) return city;
        if (district != null && district.isNotEmpty) return district;
      }
      return 'Unknown';
    } catch (e, s) {
      log('getLocationName error: $e \n $s');
      return 'Unknown';
    }
  }

  @override
  Future<String> timeZoneLocation() async {
    try {
      tz.initializeTimeZones();
      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      final location = tz.getLocation(timeZoneName);
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      return location.name;
    } catch (e, s) {
      log('timeZoneLocation error: $e \n $s');
      return MqLocationStatic.makkahTimezone;
    }
  }
}

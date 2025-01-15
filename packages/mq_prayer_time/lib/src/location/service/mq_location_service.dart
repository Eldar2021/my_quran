import 'package:geolocator/geolocator.dart';

abstract interface class MqLocationService {
  Future<Position> getCurrentLocation();

  Future<String> getLocationName(Position position);

  Future<bool> getLocationPermission();

  Future<String> timeZoneLocation();
}

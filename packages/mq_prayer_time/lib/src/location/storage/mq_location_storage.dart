import 'package:geolocator/geolocator.dart';

abstract class MqLocationStorage {
  Position? getCashedLocation();
  Future<void> setLocation(Position position);

  String? getLocationName();
  Future<void> setLocationName(String locationName);

  String? getTimeZoneLocation();
  Future<void> setTimeZoneLocation(String timeZoneLocation);
}

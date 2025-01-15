import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

abstract class MqLocationStatic {
  static const makkahName = 'Makkah';

  static const makkahTimezone = 'Asia/Riyadh';

  static final makkahPosition = Position(
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

@immutable
final class LocationJson {
  const LocationJson({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.altitude,
    required this.altitudeAccuracy,
    required this.accuracy,
    required this.heading,
    required this.headingAccuracy,
    required this.speed,
    required this.speedAccuracy,
    required this.isMocked,
    this.floor,
  });

  factory LocationJson.fromPosition(Position position) {
    return LocationJson(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: position.timestamp,
      altitude: position.altitude,
      altitudeAccuracy: position.altitudeAccuracy,
      accuracy: position.accuracy,
      heading: position.heading,
      headingAccuracy: position.headingAccuracy,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      isMocked: position.isMocked,
      floor: position.floor,
    );
  }

  factory LocationJson.fromJson(Map<String, dynamic> json) {
    return LocationJson(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      timestamp: DateTime.parse(json['timestamp'] as String),
      altitude: json['altitude'] as double,
      altitudeAccuracy: json['altitudeAccuracy'] as double,
      accuracy: json['accuracy'] as double,
      heading: json['heading'] as double,
      headingAccuracy: json['headingAccuracy'] as double,
      speed: json['speed'] as double,
      speedAccuracy: json['speedAccuracy'] as double,
      isMocked: json['isMocked'] as bool,
      floor: json['floor'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'altitude': altitude,
      'altitudeAccuracy': altitudeAccuracy,
      'accuracy': accuracy,
      'heading': heading,
      'headingAccuracy': headingAccuracy,
      'speed': speed,
      'speedAccuracy': speedAccuracy,
      'isMocked': isMocked,
      'floor': floor,
    };
  }

  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double altitude;
  final double altitudeAccuracy;
  final double accuracy;
  final double heading;
  final double headingAccuracy;
  final int? floor;
  final double speed;
  final double speedAccuracy;
  final bool isMocked;

  Position toLocation() {
    return Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      altitude: altitude,
      altitudeAccuracy: altitudeAccuracy,
      accuracy: accuracy,
      heading: heading,
      headingAccuracy: headingAccuracy,
      speed: speed,
      speedAccuracy: speedAccuracy,
      isMocked: isMocked,
      floor: floor,
    );
  }
}

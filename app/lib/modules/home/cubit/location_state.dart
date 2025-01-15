part of 'location_cubit.dart';

@immutable
final class LocationState extends Equatable {
  const LocationState({
    required this.position,
    required this.locationName,
    required this.timeZoneLocation,
  });

  final Position position;
  final String locationName;
  final String timeZoneLocation;

  @override
  List<Object> get props => [
        position,
        locationName,
        timeZoneLocation,
      ];

  LocationState copyWith({
    Position? position,
    String? locationName,
    String? timeZoneLocation,
  }) {
    return LocationState(
      position: position ?? this.position,
      locationName: locationName ?? this.locationName,
      timeZoneLocation: timeZoneLocation ?? this.timeZoneLocation,
    );
  }
}

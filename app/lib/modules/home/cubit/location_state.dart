part of 'location_cubit.dart';

@immutable
final class LocationState extends Equatable {
  const LocationState({
    required this.position,
    required this.locationName,
    required this.timeZoneLocation,
    this.eventState = const LocationEventInitial(),
  });

  final Position position;
  final String locationName;
  final String timeZoneLocation;
  final LocationEventState eventState;

  @override
  List<Object> get props => [position, locationName, timeZoneLocation, eventState];

  LocationState copyWith({
    Position? position,
    String? locationName,
    String? timeZoneLocation,
    LocationEventState? eventState,
  }) {
    return LocationState(
      position: position ?? this.position,
      locationName: locationName ?? this.locationName,
      timeZoneLocation: timeZoneLocation ?? this.timeZoneLocation,
      eventState: eventState ?? this.eventState,
    );
  }
}

@immutable
sealed class LocationEventState {
  const LocationEventState();
}

@immutable
final class LocationEventInitial extends LocationEventState {
  const LocationEventInitial();
}

@immutable
final class LocationEventKeepLocation extends LocationEventState {
  const LocationEventKeepLocation({
    required this.keepPosition,
    required this.keepLocationName,
    required this.keepTimeZoneLocation,
  });

  final Position keepPosition;
  final String keepLocationName;
  final String keepTimeZoneLocation;
}

@immutable
final class LocationEventNewLocation extends LocationEventState {
  const LocationEventNewLocation({
    required this.mewPosition,
    required this.newLocationName,
    required this.newTimeZoneLocation,
  });

  final Position mewPosition;
  final String newLocationName;
  final String newTimeZoneLocation;
}

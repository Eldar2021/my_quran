import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.client)
    : super(
        LocationState(
          position: client.initialPosition,
          locationName: client.initialLocationName,
          timeZoneLocation: client.initialTimeZoneLocation,
        ),
      );

  final MqLocationClient client;

  Position position = MqLocationStatic.makkahPosition;
  String locationName = MqLocationStatic.makkahName;
  String timeZoneLocation = MqLocationStatic.makkahTimezone;

  Future<void> init() async {
    await client.init(
      onInitailLocation: _onInitailLocation,
      onNewLocation: _updateLocation,
      onKeepLocation: _keepLocation,
    );
  }

  Future<void> updateLocation() async {
    final newState = state.copyWith(
      position: position,
      locationName: locationName,
      timeZoneLocation: timeZoneLocation,
      eventState: const LocationEventInitial(),
    );

    emit(newState);

    await client.saveData(
      position: position,
      locationName: locationName,
      timeZoneLocation: timeZoneLocation,
    );
  }

  void _onInitailLocation(
    Position mewPosition,
    String newLocationName,
    String newTimeZoneLocation,
  ) {
    position = mewPosition;
    locationName = newLocationName;
    timeZoneLocation = newTimeZoneLocation;
    updateLocation();
  }

  void _updateLocation(
    Position mewPosition,
    String newLocationName,
    String newTimeZoneLocation,
  ) {
    position = mewPosition;
    locationName = newLocationName;
    timeZoneLocation = newTimeZoneLocation;
    final newEventState = LocationEventNewLocation(
      mewPosition: mewPosition,
      newLocationName: newLocationName,
      newTimeZoneLocation: newTimeZoneLocation,
    );
    emit(state.copyWith(eventState: newEventState));
  }

  void _keepLocation(
    Position keepPosition,
    String keepLocationName,
    String keepTimeZoneLocation,
  ) {
    position = keepPosition;
    locationName = keepLocationName;
    timeZoneLocation = keepTimeZoneLocation;
    final newEventState = LocationEventKeepLocation(
      keepPosition: keepPosition,
      keepLocationName: keepLocationName,
      keepTimeZoneLocation: keepTimeZoneLocation,
    );
    emit(state.copyWith(eventState: newEventState));
  }
}

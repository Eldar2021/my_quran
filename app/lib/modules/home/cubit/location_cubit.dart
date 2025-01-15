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
      onKeepLocation: updateLocation,
      onNewLocation: keepLocation,
    );
  }

  void updateLocation(
    Position mewPosition,
    String newLocationName,
    String newTimeZoneLocation,
  ) {
    position = mewPosition;
    locationName = newLocationName;
    timeZoneLocation = newTimeZoneLocation;
  }

  void keepLocation(
    Position keepPosition,
    String keepLocationName,
    String keepTimeZoneLocation,
  ) {
    position = keepPosition;
    locationName = keepLocationName;
    timeZoneLocation = keepTimeZoneLocation;
  }
}

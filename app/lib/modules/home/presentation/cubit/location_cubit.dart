import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_quran/config/config.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.appConfig) : super(LocationInitial());
  final AppConfig appConfig;

  Future<void> fetchLocation() async {
    emit(LocationLoading());

    try {
      if (appConfig.isIntegrationTest) {
        const defaultLatitude = 21.1959;
        const defaultLongitude = 72.7933;
        final position = Position(
          latitude: defaultLatitude,
          longitude: defaultLongitude,
          altitudeAccuracy: 1,
          timestamp: DateTime.now(),
          accuracy: 1,
          headingAccuracy: 1,
          speed: 1,
          speedAccuracy: 1,
          altitude: 1,
          heading: 1,
        );
        final city = await _getCityFromCoordinates(defaultLatitude, defaultLongitude);
        emit(LocationLoaded(city: city, position: position));
        return;
      }

      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        emit(const LocationError('Location permission denied'));
        return;
      }

      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      final city = await _getCityFromCoordinates(position.latitude, position.longitude);

      emit(LocationLoaded(city: city, position: position));
    } catch (e) {
      emit(LocationError('Failed to get location: $e'));
    }
  }

  Future<bool> _handleLocationPermission() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<String> _getCityFromCoordinates(double latitude, double longitude) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first.locality ?? 'Unknown';
  }
}

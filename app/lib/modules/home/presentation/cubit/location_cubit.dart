import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    emit(LocationLoading());
    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        emit(const LocationError('Location permission denied'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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

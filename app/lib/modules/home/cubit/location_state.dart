part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  const LocationLoaded({
    required this.city,
    required this.position,
    required this.location,
  });

  final String city;
  final Position position;
  final String location;

  @override
  List<Object> get props => [city, position];
}

class LocationError extends LocationState {
  const LocationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

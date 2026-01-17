import 'dart:developer';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class QiblaCompassNotifier extends ChangeNotifier {
  QiblaCompassState _state = const QiblaCompassLoadingState();
  QiblaCompassState get state => _state;

  Future<void> getQiblaAngle() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final qiblaDegree = Qibla.qibla(
        Coordinates(position.latitude, position.longitude),
      );

      _state = QiblaCompassSuccessState(qiblaDegree);
      notifyListeners();
    } on Object catch (e) {
      log('getQiblaAngle error', error: e);
      _state = QiblaCompassErrorState(e);
      notifyListeners();
    }
  }
}

@immutable
sealed class QiblaCompassState extends Equatable {
  const QiblaCompassState();
}

@immutable
final class QiblaCompassLoadingState extends QiblaCompassState {
  const QiblaCompassLoadingState();

  @override
  List<Object?> get props => [];
}

@immutable
final class QiblaCompassSuccessState extends QiblaCompassState {
  const QiblaCompassSuccessState(this.qiblaAngle);

  final double qiblaAngle;

  @override
  List<Object?> get props => [qiblaAngle];
}

@immutable
final class QiblaCompassErrorState extends QiblaCompassState {
  const QiblaCompassErrorState(this.error);

  final Object? error;

  @override
  List<Object?> get props => [error];
}

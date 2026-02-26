import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:my_quran/components/qibla/qibla_direction_widget.dart';

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({
    required this.latitude,
    required this.longitude,
    this.size = 100,
    super.key,
  });

  final double size;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    final qiblaDirection = Qibla.qibla(
      Coordinates(latitude, longitude),
    );
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final direction = snapshot.data?.heading;
        return QiblaDirectionWidget(
          size: size,
          qiblaDirection: qiblaDirection,
          direction: direction ?? 0,
          directionDiff: (((qiblaDirection - (direction ?? 0)) % 360 + 540) % 360 - 180).round(),
          isError: direction == null,
        );
      },
    );
  }
}

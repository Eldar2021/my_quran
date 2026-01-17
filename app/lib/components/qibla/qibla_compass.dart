import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:my_quran/components/qibla/qibla_direction_widget.dart';

class QiblaCompass extends StatefulWidget {
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
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  late final double _qiblaDirection;

  @override
  void initState() {
    super.initState();
    _qiblaDirection = Qibla.qibla(
      Coordinates(widget.latitude, widget.longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final direction = snapshot.data?.heading;
        return QiblaDirectionWidget(
          size: widget.size,
          qiblaDirection: _qiblaDirection,
          direction: direction ?? 0,
          directionDiff: (((_qiblaDirection - (direction ?? 0)) % 360 + 540) % 360 - 180).round(),
          isError: direction == null,
        );
      },
    );
  }
}

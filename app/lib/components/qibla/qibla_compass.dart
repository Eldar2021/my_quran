import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:my_quran/components/qibla/qibla_compass_notifier.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  late final QiblaCompassNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = QiblaCompassNotifier();
    _notifier.getQiblaAngle();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _notifier,
      builder: (context, _) {
        final state = _notifier.state;
        if (state is QiblaCompassErrorState) {
          return const Center(child: Text('Konum verisi alınamadı.'));
        }
        if (state is QiblaCompassSuccessState) {
          return StreamBuilder<CompassEvent>(
            stream: FlutterCompass.events,
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Text('Sensör hatası');
              if (!snapshot.hasData) return const CircularProgressIndicator();

              final heading = snapshot.data!.heading;
              if (heading == null) return const Text('Cihazda pusula yok');
              var qiblaDirection = state.qiblaAngle - heading;
              if (qiblaDirection > 180) {
                qiblaDirection -= 360;
              } else if (qiblaDirection < -180) {
                qiblaDirection += 360;
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 2),
                              color: Colors.white,
                            ),
                          ),
                          Transform.rotate(
                            angle: qiblaDirection * math.pi / 180,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('K'),
                                const Icon(
                                  Icons.navigation,
                                  color: Colors.green,
                                ),
                                Text(
                                  '${qiblaDirection.abs().toStringAsFixed(0)}°',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

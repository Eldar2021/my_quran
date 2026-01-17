import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
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

              final direction = snapshot.data!.heading;
              final qiblaDirection = state.qiblaDirection;
              if (direction == null) return const Text('Cihazda pusula yok');

              return SizedBox(
                width: 100,
                height: 100,
                child: Transform.rotate(
                  angle: -2 * math.pi * (direction / 360),
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.rotationZ(qiblaDirection * math.pi / 180),
                    origin: Offset.zero,
                    child: Stack(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey, width: 2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Column(
                            children: [
                              Assets.images.kaaba.image(
                                height: 30,
                                width: 30,
                              ),
                              const Icon(Icons.navigation),
                              Text('${qiblaDirection.toInt() - direction.toInt()}°'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

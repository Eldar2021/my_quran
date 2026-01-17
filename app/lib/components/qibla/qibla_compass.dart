import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:my_quran/components/qibla/qibla_compass_notifier.dart';
import 'package:my_quran/components/qibla/qibla_direction_widget.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({
    this.size = 100,
    super.key,
  });

  final double size;

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
              return QiblaDirectionWidget(
                size: widget.size,
                direction: direction,
                qiblaDirection: qiblaDirection,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class QiblaDirectionWidget extends StatelessWidget {
  const QiblaDirectionWidget({
    required this.size,
    required this.direction,
    required this.qiblaDirection,
    super.key,
  });

  final double size;
  final double direction;
  final double qiblaDirection;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: Badge(
        backgroundColor: Colors.transparent,
        offset: Offset(-(size * 0.35), size * 0.15),
        label: IconButton(
          iconSize: size * 0.25,
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: CircleAvatar(
            radius: (size * 0.25) / 2,
            backgroundColor: colorScheme.surface,
            child: Icon(
              Icons.info,
              color: colorScheme.primary,
            ),
          ),
        ),
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
                    width: size * 0.8,
                    height: size * 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Column(
                    children: [
                      Assets.images.kaaba.image(
                        height: size * 0.3,
                        width: size * 0.3,
                      ),
                      Icon(
                        Icons.navigation,
                        color: colorScheme.primary,
                      ),
                      Text('${qiblaDirection.toInt() - direction.toInt()}°'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

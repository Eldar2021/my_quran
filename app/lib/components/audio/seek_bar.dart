import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_quran/utils/urils.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({
    required this.player,
    super.key,
    this.onChanged,
    this.onChangeEnd,
    this.sliderInActiveColor,
    this.sliderActiveColor,
  });

  final AudioPlayer player;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final Color? sliderInActiveColor;
  final Color? sliderActiveColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Slider(
              max: (player.duration ?? Duration.zero).inMilliseconds.toDouble(),
              value: min(
                player.position.inMilliseconds.toDouble(),
                (player.duration ?? Duration.zero).inMilliseconds.toDouble(),
              ),
              onChanged: (value) => onChanged?.call(value),
              onChangeEnd: (value) => onChangeEnd?.call(value),
              inactiveColor: sliderInActiveColor,
              activeColor: sliderActiveColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppRegExp.duration.firstMatch('${player.position}')?.group(1) ?? '${player.position}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    AppRegExp.duration.firstMatch('${player.duration ?? 0}')?.group(1) ??
                        '${player.duration ?? '00:00'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

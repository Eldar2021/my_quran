import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/utils/urils.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({
    required this.player,
    super.key,
    this.onChanged,
    this.onChangeEnd,
  });

  final AudioPlayer player;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    return SizedBox(
      height: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            return Row(
              children: [
                Text(
                  AppRegExp.duration.firstMatch('${player.position}')?.group(1) ?? '${player.position}',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      trackShape: CustomTrackShape(),
                    ),
                    child: Slider(
                      max: (player.duration ?? Duration.zero).inMilliseconds.toDouble(),
                      value: min(
                        player.position.inMilliseconds.toDouble(),
                        (player.duration ?? Duration.zero).inMilliseconds.toDouble(),
                      ),
                      onChanged: (value) => onChanged?.call(value),
                      onChangeEnd: (value) => onChangeEnd?.call(value),
                      inactiveColor:
                          isDark ? colorScheme.onSurface.withOpacity(0.7) : colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppRegExp.duration.firstMatch('${player.duration ?? 0}')?.group(1) ?? '${player.duration ?? 0}',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

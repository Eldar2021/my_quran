import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class QuranAudioProgressingWidget extends StatelessWidget {
  const QuranAudioProgressingWidget({
    required this.sliderValue,
    this.sliderMaxValue = 1,
    this.sliderMinValue = 0,
    this.firstTime = '00:00',
    this.lastTime = '0:00',
    this.isProgressing = false,
    this.isLoading = false,
    this.onDragSliderChanged,
    this.onFastRewind,
    this.onFastForward,
    this.onPressedPlay,
    this.onPressedPause,
    super.key,
  });

  final double sliderValue;
  final double sliderMaxValue;
  final double sliderMinValue;
  final void Function(double)? onDragSliderChanged;
  final String firstTime;
  final String lastTime;

  final bool isProgressing;
  final bool isLoading;

  final void Function()? onFastRewind;
  final void Function()? onFastForward;
  final void Function()? onPressedPlay;
  final void Function()? onPressedPause;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text(firstTime),
              const SizedBox(width: 8),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    value: sliderValue,
                    max: sliderMaxValue,
                    min: sliderMinValue,
                    inactiveColor: isDark
                        ? colorScheme.onSurface.withValues(alpha: 0.7)
                        : colorScheme.outline.withValues(alpha: 0.2),
                    onChanged: onDragSliderChanged,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(lastTime),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 40,
                padding: EdgeInsets.zero,
                onPressed: isLoading ? null : onFastRewind,
                icon: const Icon(Icons.fast_rewind),
                color: isDark ? colorScheme.inverseSurface : null,
              ),
              const SizedBox(width: 20),
              IconButton(
                iconSize: 66,
                padding: EdgeInsets.zero,
                color: colorScheme.primary,
                onPressed: isLoading
                    ? null
                    : isProgressing
                    ? onPressedPause
                    : onPressedPlay,
                icon: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(13),
                        child: CupertinoActivityIndicator(color: colorScheme.primary, radius: 20),
                      )
                    : Icon(isProgressing ? Icons.pause_circle : Icons.play_circle),
              ),
              const SizedBox(width: 20),
              IconButton(
                iconSize: 40,
                padding: EdgeInsets.zero,
                onPressed: isLoading ? null : onFastForward,
                icon: const Icon(Icons.fast_forward),
                color: isDark ? colorScheme.inverseSurface : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

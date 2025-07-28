import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class QuranReadAudioProgressingWidget extends StatelessWidget {
  const QuranReadAudioProgressingWidget({
    required this.sliderValue,
    this.sliderMax = 1,
    this.sliderMin = 0,
    this.firstTime = '00:00',
    this.lastTime = '00:00',
    this.isLoading = false,
    this.isProgressing = false,
    this.onDragSliderChanged,
    this.onPressedPlay,
    this.onPressedPause,
    super.key,
  });

  final void Function(double)? onDragSliderChanged;
  final double sliderValue;
  final double sliderMax;
  final double sliderMin;
  final String firstTime;
  final String lastTime;
  final bool isLoading;
  final bool isProgressing;
  final void Function()? onPressedPlay;
  final void Function()? onPressedPause;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton.outlined(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.primary),
            ),
            onPressed: isLoading
                ? null
                : isProgressing
                ? onPressedPause
                : onPressedPlay,
            icon: isLoading
                ? CupertinoActivityIndicator(color: colorScheme.primary)
                : Icon(isProgressing ? Icons.pause : Icons.play_arrow_rounded),
          ),
          const SizedBox(width: 5),
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
                max: sliderMax,
                min: sliderMin,
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
    );
  }
}

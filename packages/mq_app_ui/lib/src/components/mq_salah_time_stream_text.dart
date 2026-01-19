import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MqSalahTimeStreamText extends StatelessWidget {
  const MqSalahTimeStreamText({
    required this.fajrLabel,
    required this.zuhrLabel,
    required this.asrLabel,
    required this.maghribLabel,
    required this.ishaLabel,
    required this.locationLabel,
    required this.nextPrayerTime,
    required this.onLocationPressed,
    super.key,
  });

  final String fajrLabel;
  final String zuhrLabel;
  final String asrLabel;
  final String maghribLabel;
  final String ishaLabel;
  final String locationLabel;
  final Stream<(int, Duration)> nextPrayerTime;
  final void Function() onLocationPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<(int, Duration)>(
          stream: nextPrayerTime,
          builder: (context, snapshot) {
            return snapshot.data?.$1 != 0
                ? Row(
                    children: [
                      Text(
                        _getPreyerLabel(snapshot.data?.$1),
                        style: prTextTheme.bodyLarge,
                      ),
                      SizedBox(width: context.withWidth(7)),
                      Text(
                        _printDuration(
                          snapshot.data?.$2 ?? Duration.zero,
                        ),
                        style: prTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
        ),
        SizedBox(width: context.withWidth(8)),
        Flexible(
          child: TextButton.icon(
            onPressed: onLocationPressed,
            label: Text(
              locationLabel,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              foregroundColor: colorScheme.onSurface,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            icon: Assets.icons.location.svg(
              width: 12,
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _getPreyerLabel(int? index) {
    return switch (index) {
      1 => fajrLabel,
      2 => zuhrLabel,
      3 => asrLabel,
      4 => maghribLabel,
      5 => ishaLabel,
      _ => '',
    };
  }
}

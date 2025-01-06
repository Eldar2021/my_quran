import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MqSalaahCard extends StatelessWidget {
  const MqSalaahCard({
    required this.fajrLabel,
    required this.zuhrLabel,
    required this.asrLabel,
    required this.maghribLabel,
    required this.ishaLabel,
    required this.fajrTime,
    required this.zuhrTime,
    required this.asrTime,
    required this.maghribTime,
    required this.ishaTime,
    required this.fajrActive,
    required this.zuhrActive,
    required this.asrActive,
    required this.maghribActive,
    required this.ishaActive,
    required this.currentTime,
    required this.locationLabel,
    required this.onLocationPressed,
    this.location,
    super.key,
  });

  final String fajrLabel;
  final String zuhrLabel;
  final String asrLabel;
  final String maghribLabel;
  final String ishaLabel;
  final String fajrTime;
  final String zuhrTime;
  final String asrTime;
  final String maghribTime;
  final String ishaTime;
  final bool fajrActive;
  final bool zuhrActive;
  final bool asrActive;
  final bool maghribActive;
  final bool ishaActive;

  final String currentTime;
  final String locationLabel;
  final String? location;

  final void Function() onLocationPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return GradientDecoratedBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      SalaahItemTimeCard(
                        salaahName: fajrLabel,
                        timeOfClock: fajrTime,
                        isActive: fajrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: zuhrLabel,
                        timeOfClock: zuhrTime,
                        isActive: zuhrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: asrLabel,
                        timeOfClock: asrTime,
                        isActive: asrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: maghribLabel,
                        timeOfClock: maghribTime,
                        isActive: maghribActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: ishaLabel,
                        timeOfClock: ishaLabel,
                        isActive: ishaActive,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        currentTime,
                        style: prTextTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: onLocationPressed,
                        label: Text(locationLabel),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 110,
              height: 100,
              child: AnimatedAnalogClock(
                size: 120,
                location: location,
                hourHandColor: colorScheme.onSurface,
                minuteHandColor: colorScheme.onSurface,
                secondHandColor: colorScheme.primary,
                centerDotColor: colorScheme.primary,
                extendHourHand: true,
                extendMinuteHand: true,
                extendSecondHand: true,
                dialType: DialType.numberAndDashes,
                numberColor: colorScheme.onSurface,
                hourDashColor: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalaahItemTimeCard extends StatelessWidget {
  const SalaahItemTimeCard({
    required this.salaahName,
    required this.timeOfClock,
    this.isActive = true,
    super.key,
  });

  final String salaahName;
  final String timeOfClock;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isActive
          ? colorScheme.primary
          : isDark
              ? colorScheme.onSurface.withOpacity(0.9)
              : colorScheme.shadow.withOpacity(0.8),
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Text(
          salaahName,
          style: prTextTheme.bodyMedium?.copyWith(
            color: (!isActive && isDark) ? colorScheme.surface : colorScheme.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

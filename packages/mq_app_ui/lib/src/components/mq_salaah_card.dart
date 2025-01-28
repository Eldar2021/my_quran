import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

class MqSalaahCard extends StatefulWidget {
  const MqSalaahCard({
    required this.lat,
    required this.lon,
    required this.fajrLabel,
    required this.zuhrLabel,
    required this.asrLabel,
    required this.maghribLabel,
    required this.ishaLabel,
    required this.locationLabel,
    required this.onLocationPressed,
    required this.location,
    super.key,
  });

  final double lat;
  final double lon;
  final String fajrLabel;
  final String zuhrLabel;
  final String asrLabel;
  final String maghribLabel;
  final String ishaLabel;
  final String locationLabel;
  final String location;
  final void Function() onLocationPressed;

  @override
  State<MqSalaahCard> createState() => _MqSalaahCardState();
}

class _MqSalaahCardState extends State<MqSalaahCard> {
  late final PrayerTimesService _prayerTimesService;
  late MqPrayerTime _prayerTimes;

  @override
  void initState() {
    _prayerTimesService = const PrayerTimesService();
    _prayerTimes = _prayerTimesService.getPrayerTimes(
      latitude: widget.lat,
      longitude: widget.lon,
      location: widget.location,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final prTextTheme = Theme.of(context).primaryTextTheme;
    return GradientDecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(context.withWidth(10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: context.withWidth(7),
                    runSpacing: context.withWidth(6),
                    children: [
                      SalaahItemTimeCard(
                        salaahName: widget.fajrLabel,
                        timeOfClock: _prayerTimes.fajrTime,
                        isActive: _prayerTimes.fajrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.zuhrLabel,
                        timeOfClock: _prayerTimes.dhuhrTime,
                        isActive: _prayerTimes.dhuhrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.asrLabel,
                        timeOfClock: _prayerTimes.asrTime,
                        isActive: _prayerTimes.asrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.maghribLabel,
                        timeOfClock: _prayerTimes.maghribTime,
                        isActive: _prayerTimes.maghribActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.ishaLabel,
                        timeOfClock: _prayerTimes.ishaTime,
                        isActive: _prayerTimes.ishaActive,
                      ),
                    ],
                  ),
                  SizedBox(height: context.withWidth(8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: context.withWidth(8)),
                      Flexible(
                        child: TextButton.icon(
                          onPressed: widget.onLocationPressed,
                          label: Text(
                            widget.locationLabel,
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
                  ),
                ],
              ),
            ),
            SizedBox(width: context.withWidth(7)),
            AnimatedAnalogClock(
              size: context.withWidth(99),
              location: widget.location,
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
        borderRadius: BorderRadius.circular(
          context.withWidth(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.withWidth(5),
          horizontal: context.withWidth(7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              salaahName,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.surface : colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: context.withWidth(14),
              ),
            ),
            Text(
              timeOfClock,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.surface : colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: context.withWidth(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  late Stream<(int, Duration)> _nextPrayerTime;

  @override
  void initState() {
    _prayerTimesService = const PrayerTimesService();
    _setPrayersTime();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MqSalaahCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setPrayersTime();
    setState(() {});
  }

  void _setPrayersTime() {
    _prayerTimes = _prayerTimesService.getPrayerTimes(
      latitude: widget.lat,
      longitude: widget.lon,
      location: widget.location,
    );
    _nextPrayerTime = Stream.periodic(const Duration(seconds: 1), (_) => _nextPrayer);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
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
                        isActive: !_prayerTimes.fajrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.zuhrLabel,
                        timeOfClock: _prayerTimes.dhuhrTime,
                        isActive: !_prayerTimes.dhuhrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.asrLabel,
                        timeOfClock: _prayerTimes.asrTime,
                        isActive: !_prayerTimes.asrActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.maghribLabel,
                        timeOfClock: _prayerTimes.maghribTime,
                        isActive: !_prayerTimes.maghribActive,
                      ),
                      SalaahItemTimeCard(
                        salaahName: widget.ishaLabel,
                        timeOfClock: _prayerTimes.ishaTime,
                        isActive: !_prayerTimes.ishaActive,
                      ),
                    ],
                  ),
                  SizedBox(height: context.withWidth(8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<(int, Duration)>(
                        stream: _nextPrayerTime,
                        builder: (context, snapshot) {
                          return snapshot.data?.$1 != 0
                              ? Row(
                                  children: [
                                    Text(_getPreyerLabel(snapshot.data?.$1), style: prTextTheme.bodyLarge),
                                    SizedBox(width: context.withWidth(7)),
                                    Text(
                                      _printDuration(snapshot.data?.$2 ?? Duration.zero),
                                      style: prTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      SizedBox(width: context.withWidth(8)),
                      Flexible(
                        child: TextButton.icon(
                          onPressed: widget.onLocationPressed,
                          label: Text(widget.locationLabel, maxLines: 2, overflow: TextOverflow.fade),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            foregroundColor: colorScheme.onSurface,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          icon: Assets.icons.location.svg(
                            width: 12,
                            colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
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

  (int, Duration) get _nextPrayer {
    final now = DateTime.now();
    if (now.isBefore(_prayerTimes.fajr)) {
      return (1, _prayerTimes.fajr.difference(now));
    } else if (now.isBefore(_prayerTimes.dhuhr)) {
      return (2, _prayerTimes.dhuhr.difference(now));
    } else if (now.isBefore(_prayerTimes.asr)) {
      return (3, _prayerTimes.asr.difference(now));
    } else if (now.isBefore(_prayerTimes.maghrib)) {
      return (4, _prayerTimes.maghrib.difference(now));
    } else if (now.isBefore(_prayerTimes.isha)) {
      return (4, _prayerTimes.isha.difference(now));
    }
    return (0, Duration.zero);
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _getPreyerLabel(int? index) {
    return switch (index) {
      1 => widget.fajrLabel,
      2 => widget.zuhrLabel,
      3 => widget.asrLabel,
      4 => widget.maghribLabel,
      5 => widget.ishaLabel,
      _ => '',
    };
  }
}

class SalaahItemTimeCard extends StatelessWidget {
  const SalaahItemTimeCard({required this.salaahName, required this.timeOfClock, this.isActive = true, super.key});

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
          ? colorScheme.surface.withValues(alpha: 0.5)
          : colorScheme.shadow.withValues(alpha: 0.5),
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.withWidth(8))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.withWidth(5), horizontal: context.withWidth(7)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              salaahName,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.onSurface : colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: context.withWidth(14),
              ),
            ),
            Text(
              timeOfClock,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.onSurface : colorScheme.onPrimary,
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

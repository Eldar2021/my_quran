import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

class MqSalaahCard extends StatefulWidget {
  const MqSalaahCard({
    required this.lat,
    required this.lon,
    required this.fajrLabel,
    required this.sunriseLabel,
    required this.zuhrLabel,
    required this.asrLabel,
    required this.maghribLabel,
    required this.ishaLabel,
    required this.tahajjudLabel,
    required this.locationLabel,
    required this.onLocationPressed,
    required this.location,
    this.extraWidget,
    super.key,
  });

  final double lat;
  final double lon;
  final String fajrLabel;
  final String sunriseLabel;
  final String zuhrLabel;
  final String asrLabel;
  final String maghribLabel;
  final String ishaLabel;
  final String tahajjudLabel;
  final String locationLabel;
  final String location;
  final void Function() onLocationPressed;
  final Widget? extraWidget;

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
    _nextPrayerTime = Stream.periodic(
      const Duration(seconds: 1),
      (_) => _nextPrayer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientDecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(context.withWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: context.withWidth(8),
              children: [
                SalaahItemTimeCard(
                  salaahName: widget.fajrLabel,
                  timeOfClock: _prayerTimes.fajrTime,
                  isActive: !_prayerTimes.fajrActive,
                ),
                SalaahItemTimeCard(
                  salaahName: widget.sunriseLabel,
                  timeOfClock: _prayerTimes.sunriseTime,
                  isActive: !_prayerTimes.sunriseActive,
                ),
                SalaahItemTimeCard(
                  salaahName: widget.zuhrLabel,
                  timeOfClock: _prayerTimes.dhuhrTime,
                  isActive: !_prayerTimes.dhuhrActive,
                ),
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 85) {
                        return const SizedBox.shrink();
                      }
                      return SalaahItemTimeCard(
                        salaahName: widget.tahajjudLabel,
                        timeOfClock: _prayerTimes.tahajjudTime,
                        isActive: !_prayerTimes.tahajjudActive,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: context.withWidth(8)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: context.withWidth(8),
                      children: [
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
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: MqSalahTimeStreamText(
                        fajrLabel: widget.fajrLabel,
                        zuhrLabel: widget.zuhrLabel,
                        asrLabel: widget.asrLabel,
                        maghribLabel: widget.maghribLabel,
                        ishaLabel: widget.ishaLabel,
                        locationLabel: widget.locationLabel,
                        onLocationPressed: widget.onLocationPressed,
                        nextPrayerTime: _nextPrayerTime,
                      ),
                    ),
                  ],
                ),
                if (widget.extraWidget != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: widget.extraWidget,
                  ),
              ],
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
}

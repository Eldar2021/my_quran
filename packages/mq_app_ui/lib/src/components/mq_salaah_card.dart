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
    required this.qiblaCompassWarning,
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
  final String qiblaCompassWarning;
  final void Function() onLocationPressed;
  final Widget? extraWidget;

  @override
  State<MqSalaahCard> createState() => _MqSalaahCardState();
}

class _MqSalaahCardState extends State<MqSalaahCard> {
  late final PrayerTimesService _prayerTimesService;
  late final ScrollController _scrollController;
  late MqPrayerTime _prayerTimes;
  late Stream<(int, Duration)> _nextPrayerTime;

  @override
  void initState() {
    _prayerTimesService = const PrayerTimesService();
    _scrollController = ScrollController();
    _setPrayersTime();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActive();
    });
  }

  @override
  void didUpdateWidget(covariant MqSalaahCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setPrayersTime();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActive();
    });
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
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 45,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  SalaahItemTimeCard(
                    salaahName: widget.fajrLabel,
                    timeOfClock: _prayerTimes.fajrTime,
                    isActive: !_prayerTimes.fajrActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.sunriseLabel,
                    timeOfClock: _prayerTimes.sunriseTime,
                    isActive: !_prayerTimes.sunriseActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.zuhrLabel,
                    timeOfClock: _prayerTimes.dhuhrTime,
                    isActive: !_prayerTimes.dhuhrActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.asrLabel,
                    timeOfClock: _prayerTimes.asrTime,
                    isActive: !_prayerTimes.asrActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.maghribLabel,
                    timeOfClock: _prayerTimes.maghribTime,
                    isActive: !_prayerTimes.maghribActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.ishaLabel,
                    timeOfClock: _prayerTimes.ishaTime,
                    isActive: !_prayerTimes.ishaActive,
                  ),
                  const SizedBox(width: 8),
                  SalaahItemTimeCard(
                    salaahName: widget.tahajjudLabel,
                    timeOfClock: _prayerTimes.tahajjudTime,
                    isActive: !_prayerTimes.tahajjudActive,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MqSalahTimeStreamText(
                          fajrLabel: widget.fajrLabel,
                          zuhrLabel: widget.zuhrLabel,
                          asrLabel: widget.asrLabel,
                          maghribLabel: widget.maghribLabel,
                          ishaLabel: widget.ishaLabel,
                          tahajjudLabel: widget.tahajjudLabel,
                          locationLabel: widget.locationLabel,
                          onLocationPressed: widget.onLocationPressed,
                          nextPrayerTime: _nextPrayerTime,
                        ),
                        const SizedBox(height: 4),
                        Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: widget.qiblaCompassWarning,
                          showDuration: const Duration(seconds: 6),
                          child: Text(
                            widget.qiblaCompassWarning,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.extraWidget != null) widget.extraWidget!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToActive() {
    if (!_scrollController.hasClients) return;
    final index = _getActiveIndex();
    if (index < 3) return;
    _scrollController.animateTo(
      index * 50.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  int _getActiveIndex() {
    if (_prayerTimes.fajrActive) return 0;
    if (_prayerTimes.sunriseActive) return 1;
    if (_prayerTimes.dhuhrActive) return 2;
    if (_prayerTimes.asrActive) return 3;
    if (_prayerTimes.maghribActive) return 4;
    if (_prayerTimes.ishaActive) return 5;
    if (_prayerTimes.tahajjudActive) return 6;
    return 0;
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
      return (5, _prayerTimes.isha.difference(now));
    } else if (now.isBefore(_prayerTimes.tahajjud)) {
      return (6, _prayerTimes.tahajjud.difference(now));
    }
    return (0, Duration.zero);
  }
}

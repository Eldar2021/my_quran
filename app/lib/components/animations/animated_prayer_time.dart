import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PrayerTimeAnimation extends StatefulWidget {
  const PrayerTimeAnimation({
    required this.bagymdatTime,
    required this.beshimTime,
    required this.asrTime,
    required this.shamTime,
    required this.kuptanTime,
    super.key,
  });

  final DateTime bagymdatTime;
  final DateTime beshimTime;
  final DateTime asrTime;
  final DateTime shamTime;
  final DateTime kuptanTime;

  @override
  State<PrayerTimeAnimation> createState() => _PrayerTimeAnimationState();
}

class _PrayerTimeAnimationState extends State<PrayerTimeAnimation> {
  Stream<DateTime>? _subscription;
  double timelineValue = 0;

  @override
  void initState() {
    _subscription = Stream.periodic(const Duration(seconds: 1), (v) {
      final now = DateTime.now();
      timelineValue = _calculateTimelineValue(now);

      return now;
    });
    super.initState();
  }

  double _calculateTimelineValue(DateTime now) {
    final totalDuration = widget.kuptanTime.difference(widget.bagymdatTime).inMinutes.toDouble();
    final passedDuration = now.difference(widget.bagymdatTime).inMinutes.toDouble();
    final percentage = (passedDuration / totalDuration) * 100;
    return percentage.clamp(0, 100);
  }

  double _getEventTimelineValue(DateTime eventTime) {
    final totalDuration = widget.kuptanTime.difference(widget.bagymdatTime).inMinutes.toDouble();
    final eventDuration = eventTime.difference(widget.bagymdatTime).inMinutes.toDouble();
    final percentage = (eventDuration / totalDuration) * 100;
    return percentage.clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: StreamBuilder<Object>(
        stream: _subscription,
        builder: (context, snapshot) {
          return SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 180,
                endAngle: 0,
                showLabels: false,
                canScaleToFit: true,
                showTicks: false,
                radiusFactor: 1.6,
                axisLineStyle: const AxisLineStyle(color: Color(0xFFE3E3E5)),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: timelineValue,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationDuration: 1200,
                    sizeUnit: GaugeSizeUnit.factor,
                    gradient: const SweepGradient(colors: <Color>[Color(0xFFF6684E), Color(0xFFF67E49)]),
                    color: const Color(0xFF00A8B5),
                    width: 0.055,
                  ),
                  WidgetPointer(
                    value: _getEventTimelineValue(widget.bagymdatTime),
                    child: CircleAvatar(
                      backgroundColor: _getEventTimelineValue(widget.bagymdatTime) <= timelineValue
                          ? const Color(0xFFF6684E)
                          : const Color(0xFFE3E3E5),
                      child: Assets.icons.moon.svg(),
                    ),
                  ),
                  WidgetPointer(
                    value: _getEventTimelineValue(widget.beshimTime),
                    child: CircleAvatar(
                      backgroundColor: _getEventTimelineValue(widget.beshimTime) <= timelineValue
                          ? const Color(0xFFF6684E)
                          : const Color(0xFFE3E3E5),
                      child: Assets.icons.beshim.svg(),
                    ),
                  ),
                  WidgetPointer(
                    value: _getEventTimelineValue(widget.asrTime),
                    child: CircleAvatar(
                      backgroundColor: _getEventTimelineValue(widget.asrTime) <= timelineValue
                          ? const Color(0xFFF6684E)
                          : const Color(0xFFE3E3E5),
                      child: Assets.icons.asrTime.svg(),
                    ),
                  ),
                  WidgetPointer(
                    value: _getEventTimelineValue(widget.shamTime),
                    child: CircleAvatar(
                      backgroundColor: _getEventTimelineValue(widget.shamTime) <= timelineValue
                          ? const Color(0xFFF6684E)
                          : const Color(0xFFE3E3E5),
                      child: Assets.icons.sham.svg(),
                    ),
                  ),
                  WidgetPointer(
                    value: _getEventTimelineValue(widget.kuptanTime),
                    child: CircleAvatar(
                      backgroundColor: _getEventTimelineValue(widget.kuptanTime) <= timelineValue
                          ? const Color(0xFFF6684E)
                          : const Color(0xFFE3E3E5),
                      child: Assets.icons.moon.svg(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

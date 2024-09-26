import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class PrayTimeWidget extends StatefulWidget {
  const PrayTimeWidget({super.key});

  @override
  State<PrayTimeWidget> createState() => _PrayTimeWidgetState();
}

class _PrayTimeWidgetState extends State<PrayTimeWidget> {
  late Timer _timer;
  String _nextPrayerName = '';
  String _nextPrayerTime = '';

  @override
  void initState() {
    super.initState();
    _updateNextPrayerDetails();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _updateNextPrayerDetails();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateNextPrayerDetails() {
    final now = DateTime.now();
    final nextPrayer = _getNextPrayerDetails(now);
    setState(() {
      _nextPrayerName = nextPrayer.name;
      _nextPrayerTime = nextPrayer.countdown;
    });
  }

  _PrayerDetails _getNextPrayerDetails(DateTime now) {
    final prayerTimes = [
      _PrayerTime('Bagymdat', DateTime.now().copyWith(hour: 5, minute: 33)),
      _PrayerTime('Beshim', DateTime.now().copyWith(hour: 13, minute: 21)),
      _PrayerTime('Asr', DateTime.now().copyWith(hour: 17, minute: 44)),
      _PrayerTime('Sham', DateTime.now().copyWith(hour: 19, minute: 01)),
      _PrayerTime('Kuptan', DateTime.now().copyWith(hour: 21, minute: 09)),
    ];

    for (final prayerTime in prayerTimes) {
      if (now.isBefore(prayerTime.time)) {
        final duration = prayerTime.time.difference(now);
        return _PrayerDetails(prayerTime.name, _formatDuration(duration));
      }
    }

    return _PrayerDetails('Bagymdat', '');
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours h $minutes min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is LocationLoaded) {
                      return Text(
                        'c. ${state.city}',
                        style: TextStyle(
                          color: const Color(0xff1C274C).withOpacity(0.5),
                          fontSize: 16,
                        ),
                      );
                    } else if (state is LocationError) {
                      return Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const Text('Location not available');
                  },
                ),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: const TextStyle(
                    color: Color(0xff1C274C),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: SizedBox(
                    height: 64,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'This feature will be added in the future...',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xff1C274C),
                              padding: EdgeInsets.only(bottom: 30, top: 10, left: 10),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            '${context.l10n.nextPrayer}: $_nextPrayerName $_nextPrayerTime',
                            style: const TextStyle(
                              color: Color(0xff1C274C),
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: Assets.icons.time.svg(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: PrayerTimeAnimation(
              bagymdatTime: DateTime.now().copyWith(hour: 5),
              beshimTime: DateTime.now().copyWith(hour: 13),
              asrTime: DateTime.now().copyWith(hour: 17),
              shamTime: DateTime.now().copyWith(hour: 19),
              kuptanTime: DateTime.now().copyWith(hour: 21),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerDetails {
  _PrayerDetails(this.name, this.countdown);
  final String name;
  final String countdown;
}

class _PrayerTime {
  _PrayerTime(this.name, this.time);
  final String name;
  final DateTime time;
}

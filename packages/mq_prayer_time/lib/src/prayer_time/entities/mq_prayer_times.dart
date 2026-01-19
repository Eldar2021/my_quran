import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
final class MqPrayerTime {
  const MqPrayerTime({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  DateTime get tahajjud {
    var nightDuration = fajr.difference(isha);
    if (nightDuration.isNegative) {
      nightDuration += const Duration(days: 1);
    }
    return isha.add(nightDuration * 2 ~/ 3);
  }

  String get fajrTime => DateFormat.Hm().format(fajr);
  String get sunriseTime => DateFormat.Hm().format(sunrise);
  String get dhuhrTime => DateFormat.Hm().format(dhuhr);
  String get asrTime => DateFormat.Hm().format(asr);
  String get maghribTime => DateFormat.Hm().format(maghrib);
  String get ishaTime => DateFormat.Hm().format(isha);
  String get tahajjudTime => DateFormat.Hm().format(tahajjud);

  bool get fajrActive {
    final now = DateTime.now();
    return now.isBefore(fajr);
  }

  bool get sunriseActive {
    final now = DateTime.now();
    return now.isBefore(sunrise);
  }

  bool get dhuhrActive {
    final now = DateTime.now();
    return now.isBefore(dhuhr);
  }

  bool get asrActive {
    final now = DateTime.now();
    return now.isBefore(asr);
  }

  bool get maghribActive {
    final now = DateTime.now();
    return now.isBefore(maghrib);
  }

  bool get ishaActive {
    final now = DateTime.now();
    return now.isBefore(isha);
  }

  bool get tahajjudActive {
    final now = DateTime.now();
    return now.isBefore(tahajjud);
  }
}

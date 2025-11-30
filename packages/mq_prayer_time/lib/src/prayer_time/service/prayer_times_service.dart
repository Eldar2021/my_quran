import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@immutable
final class PrayerTimesService {
  const PrayerTimesService();

  MqPrayerTime getPrayerTimes({
    required double latitude,
    required double longitude,
    required String location,
  }) {
    tz.initializeTimeZones();

    final timezone = tz.getLocation(location);
    final date = tz.TZDateTime.from(DateTime.now(), timezone);
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationParameters(
      method: CalculationMethod.muslimWorldLeague,
      madhab: Madhab.hanafi,
      fajrAngle: 19.5,
      ishaAngle: 17.5,
    );

    final prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true,
    );

    final fajrTime = tz.TZDateTime.from(
      prayerTimes.fajr,
      timezone,
    );

    final sunriseTime = tz.TZDateTime.from(
      prayerTimes.sunrise,
      timezone,
    );

    final dhuhrTime = tz.TZDateTime.from(
      prayerTimes.dhuhr,
      timezone,
    );

    final asrTime = tz.TZDateTime.from(
      prayerTimes.asr,
      timezone,
    );

    final maghribTime = tz.TZDateTime.from(
      prayerTimes.maghrib,
      timezone,
    );

    final ishaTime = tz.TZDateTime.from(
      prayerTimes.isha,
      timezone,
    );

    return MqPrayerTime(
      fajr: fajrTime,
      sunrise: sunriseTime,
      dhuhr: dhuhrTime,
      asr: asrTime,
      maghrib: maghribTime,
      isha: ishaTime,
    );
  }
}

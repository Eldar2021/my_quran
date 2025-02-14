import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@immutable
final class PrayerTimesService {
  const PrayerTimesService();

  MqPrayerTime getPrayerTimes({required double latitude, required double longitude, required String location}) {
    tz.initializeTimeZones();

    final timezone = tz.getLocation(location);
    final date = tz.TZDateTime.from(DateTime.now(), timezone);
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslimWorldLeague() as CalculationParameters;

    // ignore: cascade_invocations
    params.madhab = Madhab.hanafi;

    final prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true,
    );

    final fajrTime = tz.TZDateTime.from(prayerTimes.fajr ?? DateTime.now(), timezone);

    final sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise ?? DateTime.now(), timezone);

    final dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr ?? DateTime.now(), timezone);

    final asrTime = tz.TZDateTime.from(prayerTimes.asr ?? DateTime.now(), timezone);

    final maghribTime = tz.TZDateTime.from(prayerTimes.maghrib ?? DateTime.now(), timezone);

    final ishaTime = tz.TZDateTime.from(prayerTimes.isha ?? DateTime.now(), timezone);

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

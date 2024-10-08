import 'package:meta/meta.dart';
import 'package:my_quran/modules/namaz_time/data/model/namaz_times_response.dart';

@immutable
final class NamazTimesEntity {
  const NamazTimesEntity({
    required this.id,
    required this.title,
    required this.subLocations,
    this.titleRu,
    this.titleEn,
    this.lat,
    this.lon,
    this.bagymdatOffset,
    this.sunriseOffset,
    this.zuhrOffset,
    this.asrOffset,
    this.magribOffset,
    this.ishaOffset,
    this.useFormula,
    this.startDateTz,
    this.startDateSecondTz,
    this.timezone,
    this.secondTimezone,
  });

  final int id;
  final String title;
  final String? titleRu;
  final String? titleEn;
  final double? lat;
  final double? lon;
  final int? bagymdatOffset;
  final int? sunriseOffset;
  final int? zuhrOffset;
  final int? asrOffset;
  final int? magribOffset;
  final int? ishaOffset;
  final bool? useFormula;
  final DateTime? startDateTz;
  final DateTime? startDateSecondTz;
  final String? timezone;
  final String? secondTimezone;
  final List<SubLocation> subLocations;
}

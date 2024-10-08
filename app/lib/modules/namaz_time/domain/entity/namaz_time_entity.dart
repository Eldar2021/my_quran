import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@immutable
final class NamazTimesEntity {
  const NamazTimesEntity({
    required this.id,
    this.title,
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
    this.validUntil,
    this.startDateTz,
    this.startDateSecondTz,
    this.timezone,
    this.secondTimezone,
    this.times,
  });

  final int id;
  final String? title;
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
  final int? useFormula;
  final String? validUntil;
  final String? startDateTz;
  final String? startDateSecondTz;
  final int? timezone;
  final int? secondTimezone;
  final Map<String, List<String>>? times;

  List<String>? getTodaysTimes() {
    final today = DateFormat('dd.MM').format(DateTime.now());
    return times![today];
  }
}

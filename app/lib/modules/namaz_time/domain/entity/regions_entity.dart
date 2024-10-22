import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class RegionsEntity {
  const RegionsEntity({
    required this.id,
    required this.list,
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
    this.startDateTz,
    this.startDateSecondTz,
    this.timezone,
    this.secondTimezone,
  });

  final int id;
  final String? title;
  final String? titleRu;
  final String? titleEn;
  final double? lat;
  final double? lon;
  final String? bagymdatOffset;
  final String? sunriseOffset;
  final String? zuhrOffset;
  final String? asrOffset;
  final String? magribOffset;
  final String? ishaOffset;
  final String? useFormula;
  final String? startDateTz;
  final String? startDateSecondTz;
  final String? timezone;
  final String? secondTimezone;
  final List<Region> list;
}

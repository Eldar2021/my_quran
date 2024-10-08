import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'namaz_times_model_response.g.dart';

@JsonSerializable()
@immutable
class NamazTimesResponse {
  const NamazTimesResponse({
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

  factory NamazTimesResponse.fromJson(Map<String, dynamic> json) => _$NamazTimesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NamazTimesResponseToJson(this);

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
}

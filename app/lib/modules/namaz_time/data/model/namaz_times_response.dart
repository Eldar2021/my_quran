import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'namaz_times_response.g.dart';

@JsonSerializable()
@immutable
class NamazTimesResponse {
  const NamazTimesResponse({
    required this.id,
    required this.title,
    this.subLocations,
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

  factory NamazTimesResponse.fromJson(Map<String, dynamic> json) => _$NamazTimesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NamazTimesResponseToJson(this);
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
  final List<SubLocation>? subLocations;
}

class SubLocation {
  SubLocation({
    required this.id,
    required this.title,
    required this.titleRu,
    required this.titleEn,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubLocation.fromJson(Map<String, dynamic> json) {
    return SubLocation(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      titleRu: json['title_ru'] as String,
      titleEn: json['title_en'] as String,
      parentId: (json['parent_id'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final int id;
  final String title;
  final String titleRu;
  final String titleEn;
  final int parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_ru': titleRu,
      'title_en': titleEn,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

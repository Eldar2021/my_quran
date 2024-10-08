import 'package:json_annotation/json_annotation.dart';

part 'region_model_response.g.dart';

@JsonSerializable()
class RegionModelResponse {
  RegionModelResponse({
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

  factory RegionModelResponse.fromJson(Map<String, dynamic> json) => _$RegionModelResponseFromJson(json);
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
  Map<String, dynamic> toJson() => _$RegionModelResponseToJson(this);
}

@JsonSerializable()
class Region {
  Region({
    required this.id,
    this.title,
    this.titleRu,
    this.titleEn,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  final int id;
  final String? title;
  final String? titleRu;
  final String? titleEn;
  final int? parentId;
  final String? createdAt;
  final String? updatedAt;
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

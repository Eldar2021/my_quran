// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionModelResponse _$RegionModelResponseFromJson(Map<String, dynamic> json) =>
    RegionModelResponse(
      id: (json['id'] as num).toInt(),
      list: (json['list'] as List<dynamic>)
          .map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      titleRu: json['titleRu'] as String?,
      titleEn: json['titleEn'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      bagymdatOffset: json['bagymdatOffset'] as String?,
      sunriseOffset: json['sunriseOffset'] as String?,
      zuhrOffset: json['zuhrOffset'] as String?,
      asrOffset: json['asrOffset'] as String?,
      magribOffset: json['magribOffset'] as String?,
      ishaOffset: json['ishaOffset'] as String?,
      useFormula: json['useFormula'] as String?,
      startDateTz: json['startDateTz'] as String?,
      startDateSecondTz: json['startDateSecondTz'] as String?,
      timezone: json['timezone'] as String?,
      secondTimezone: json['secondTimezone'] as String?,
    );

Map<String, dynamic> _$RegionModelResponseToJson(
        RegionModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleRu': instance.titleRu,
      'titleEn': instance.titleEn,
      'lat': instance.lat,
      'lon': instance.lon,
      'bagymdatOffset': instance.bagymdatOffset,
      'sunriseOffset': instance.sunriseOffset,
      'zuhrOffset': instance.zuhrOffset,
      'asrOffset': instance.asrOffset,
      'magribOffset': instance.magribOffset,
      'ishaOffset': instance.ishaOffset,
      'useFormula': instance.useFormula,
      'startDateTz': instance.startDateTz,
      'startDateSecondTz': instance.startDateSecondTz,
      'timezone': instance.timezone,
      'secondTimezone': instance.secondTimezone,
      'list': instance.list,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      titleRu: json['titleRu'] as String?,
      titleEn: json['titleEn'] as String?,
      parentId: (json['parentId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleRu': instance.titleRu,
      'titleEn': instance.titleEn,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

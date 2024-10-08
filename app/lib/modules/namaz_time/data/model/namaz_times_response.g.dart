// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namaz_times_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamazTimesResponse _$NamazTimesResponseFromJson(Map<String, dynamic> json) =>
    NamazTimesResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      subLocations: (json['subLocations'] as List<dynamic>?)
          ?.map((e) => SubLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      titleRu: json['titleRu'] as String?,
      titleEn: json['titleEn'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      bagymdatOffset: (json['bagymdatOffset'] as num?)?.toInt(),
      sunriseOffset: (json['sunriseOffset'] as num?)?.toInt(),
      zuhrOffset: (json['zuhrOffset'] as num?)?.toInt(),
      asrOffset: (json['asrOffset'] as num?)?.toInt(),
      magribOffset: (json['magribOffset'] as num?)?.toInt(),
      ishaOffset: (json['ishaOffset'] as num?)?.toInt(),
      useFormula: json['useFormula'] as bool?,
      startDateTz: json['startDateTz'] == null
          ? null
          : DateTime.parse(json['startDateTz'] as String),
      startDateSecondTz: json['startDateSecondTz'] == null
          ? null
          : DateTime.parse(json['startDateSecondTz'] as String),
      timezone: json['timezone'] as String?,
      secondTimezone: json['secondTimezone'] as String?,
    );

Map<String, dynamic> _$NamazTimesResponseToJson(NamazTimesResponse instance) =>
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
      'startDateTz': instance.startDateTz?.toIso8601String(),
      'startDateSecondTz': instance.startDateSecondTz?.toIso8601String(),
      'timezone': instance.timezone,
      'secondTimezone': instance.secondTimezone,
      'subLocations': instance.subLocations,
    };

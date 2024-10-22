// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namaz_times_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamazTimesResponse _$NamazTimesResponseFromJson(Map<String, dynamic> json) =>
    NamazTimesResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
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
      useFormula: (json['useFormula'] as num?)?.toInt(),
      validUntil: json['validUntil'] as String?,
      startDateTz: json['startDateTz'] as String?,
      startDateSecondTz: json['startDateSecondTz'] as String?,
      timezone: (json['timezone'] as num?)?.toInt(),
      secondTimezone: (json['secondTimezone'] as num?)?.toInt(),
      times: (json['times'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
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
      'validUntil': instance.validUntil,
      'startDateTz': instance.startDateTz,
      'startDateSecondTz': instance.startDateSecondTz,
      'timezone': instance.timezone,
      'secondTimezone': instance.secondTimezone,
      'times': instance.times,
    };

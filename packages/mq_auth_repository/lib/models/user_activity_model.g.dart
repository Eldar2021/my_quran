// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivityModel _$UserActivityModelFromJson(Map<String, dynamic> json) => UserActivityModel(
  date: DateTime.parse(json['date'] as String),
  openedApp: json['openedApp'] as bool,
  quranReadedPagesCount: (json['quranReadedPagesCount'] as num).toInt(),
  listenedQuranSeconds: (json['listenedQuranSeconds'] as num).toDouble(),
  fajrDone: json['fajrDone'] as bool,
  zuhrDone: json['zuhrDone'] as bool,
  asrDone: json['asrDone'] as bool,
  maghribDone: json['maghribDone'] as bool,
  ishaDone: json['ishaDone'] as bool,
);

Map<String, dynamic> _$UserActivityModelToJson(UserActivityModel instance) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'openedApp': instance.openedApp,
  'quranReadedPagesCount': instance.quranReadedPagesCount,
  'listenedQuranSeconds': instance.listenedQuranSeconds,
  'fajrDone': instance.fajrDone,
  'zuhrDone': instance.zuhrDone,
  'asrDone': instance.asrDone,
  'maghribDone': instance.maghribDone,
  'ishaDone': instance.ishaDone,
};

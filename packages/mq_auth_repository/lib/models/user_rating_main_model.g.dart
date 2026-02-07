// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatingMainModel _$UserRatingMainModelFromJson(Map<String, dynamic> json) => UserRatingMainModel(
  worldRank: (json['world_rank'] as num).toInt(),
  weeklyData: (json['weekly_data'] as List<dynamic>)
      .map(
        (e) => UserRatingMainWeeklyData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  countryRank: (json['country_rank'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserRatingMainModelToJson(
  UserRatingMainModel instance,
) => <String, dynamic>{
  'world_rank': instance.worldRank,
  'weekly_data': instance.weeklyData,
  'country_rank': instance.countryRank,
};

UserRatingMainWeeklyData _$UserRatingMainWeeklyDataFromJson(
  Map<String, dynamic> json,
) => UserRatingMainWeeklyData(
  date: DateTime.parse(json['date'] as String),
  readedPagesCount: (json['readed_pages_count'] as num).toInt(),
  listenedQuranByHours: (json['listened_quran_by_hours'] as num).toInt(),
);

Map<String, dynamic> _$UserRatingMainWeeklyDataToJson(
  UserRatingMainWeeklyData instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'readed_pages_count': instance.readedPagesCount,
  'listened_quran_by_hours': instance.listenedQuranByHours,
};

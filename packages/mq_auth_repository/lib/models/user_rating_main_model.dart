import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_rating_main_model.g.dart';

@JsonSerializable()
@immutable
final class UserRatingMainModel {
  const UserRatingMainModel({
    required this.worldRank,
    required this.weeklyData,
    this.countryRank,
  });

  factory UserRatingMainModel.fromJson(Map<String, dynamic> json) => _$UserRatingMainModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingMainModelToJson(this);

  @JsonKey(name: 'world_rank')
  final int worldRank;

  @JsonKey(name: 'weekly_data')
  final List<UserRatingMainWeeklyData> weeklyData;

  @JsonKey(name: 'country_rank')
  final int? countryRank;
}

@JsonSerializable()
@immutable
final class UserRatingMainWeeklyData {
  const UserRatingMainWeeklyData({
    required this.date,
    required this.readedPagesCount,
    required this.listenedQuranByHours,
  });

  factory UserRatingMainWeeklyData.fromJson(Map<String, dynamic> json) => _$UserRatingMainWeeklyDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingMainWeeklyDataToJson(this);

  @JsonKey(name: 'date')
  final DateTime date;

  @JsonKey(name: 'readed_pages_count')
  final int readedPagesCount;

  @JsonKey(name: 'listened_quran_by_hours')
  final int listenedQuranByHours;
}

import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_rating_model.g.dart';

@JsonSerializable()
@immutable
final class RatingRequestModel {
  const RatingRequestModel({
    required this.userId,
    required this.periodType,
    required this.areaType,
    this.pageSize = 20,
    this.page = 0,
  });

  factory RatingRequestModel.fromJson(Map<String, dynamic> json) => _$RatingRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingRequestModelToJson(this);

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'period_type')
  final PeriodType periodType;

  @JsonKey(name: 'area_type')
  final AreaType areaType;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'page_size')
  final int pageSize;
}

@JsonSerializable()
@immutable
final class RatingResponseModel {
  const RatingResponseModel({
    required this.periodType,
    required this.areaType,
    required this.ownerData,
    required this.pagination,
    required this.list,
  });

  factory RatingResponseModel.fromJson(Map<String, dynamic> json) => _$RatingResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingResponseModelToJson(this);

  @JsonKey(name: 'period_type')
  final PeriodType periodType;

  @JsonKey(name: 'area_type')
  final AreaType areaType;

  @JsonKey(name: 'owner_data')
  final RatingOwnerModel ownerData;

  @JsonKey(name: 'pagination')
  final RatingPaginationModel pagination;

  @JsonKey(name: 'list')
  final List<RatingParticipantModel> list;
}

@JsonSerializable()
@immutable
final class RatingParticipantModel {
  const RatingParticipantModel({
    required this.ratingNumber,
    required this.fullName,
    required this.readedPagesCount,
    this.email,
    this.userName,
    this.avatarUrl,
    this.country,
  });

  factory RatingParticipantModel.fromJson(Map<String, dynamic> json) => _$RatingParticipantModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingParticipantModelToJson(this);

  @JsonKey(name: 'rating_number')
  final int ratingNumber;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'readed_pages_count')
  final int readedPagesCount;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'country')
  final String? country;
}

@JsonSerializable()
@immutable
final class RatingPaginationModel {
  const RatingPaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.hasNext,
  });

  factory RatingPaginationModel.fromJson(Map<String, dynamic> json) => _$RatingPaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingPaginationModelToJson(this);

  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'has_next')
  final bool hasNext;
}

@JsonSerializable()
@immutable
final class RatingOwnerModel {
  const RatingOwnerModel({
    required this.ratingNumber,
    required this.readedPagesCount,
  });

  factory RatingOwnerModel.fromJson(Map<String, dynamic> json) => _$RatingOwnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingOwnerModelToJson(this);

  @JsonKey(name: 'rating_number')
  final int ratingNumber;

  @JsonKey(name: 'readed_pages_count')
  final int readedPagesCount;
}

enum PeriodType {
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('quarterly')
  quarterly,
  @JsonValue('yearly')
  yearly;

  String getValue() {
    return switch (this) {
      PeriodType.weekly => 'weekly',
      PeriodType.monthly => 'monthly',
      PeriodType.quarterly => 'quarterly',
      PeriodType.yearly => 'yearly',
    };
  }
}

enum AreaType {
  @JsonValue('world')
  world,
  @JsonValue('country')
  country;

  String getValue() {
    return switch (this) {
      AreaType.world => 'world',
      AreaType.country => 'country',
    };
  }
}

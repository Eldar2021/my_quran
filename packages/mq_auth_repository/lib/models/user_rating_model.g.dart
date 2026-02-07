// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingRequestModel _$RatingRequestModelFromJson(Map<String, dynamic> json) => RatingRequestModel(
  userId: json['user_id'] as String,
  periodType: $enumDecode(_$PeriodTypeEnumMap, json['period_type']),
  areaType: $enumDecode(_$AreaTypeEnumMap, json['area_type']),
  page: (json['page'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RatingRequestModelToJson(RatingRequestModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'period_type': _$PeriodTypeEnumMap[instance.periodType]!,
  'area_type': _$AreaTypeEnumMap[instance.areaType]!,
  'page': instance.page,
};

const _$PeriodTypeEnumMap = {
  PeriodType.weekly: 'weekly',
  PeriodType.monthly: 'monthly',
  PeriodType.threeMonth: 'three_month',
  PeriodType.year: 'year',
};

const _$AreaTypeEnumMap = {
  AreaType.world: 'world',
  AreaType.country: 'country',
};

RatingResponseModel _$RatingResponseModelFromJson(Map<String, dynamic> json) => RatingResponseModel(
  periodType: $enumDecode(_$PeriodTypeEnumMap, json['period_type']),
  areaType: $enumDecode(_$AreaTypeEnumMap, json['area_type']),
  ownerData: RatingOwnerModel.fromJson(
    json['owner_data'] as Map<String, dynamic>,
  ),
  pagination: RatingPaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
  list: (json['list'] as List<dynamic>)
      .map(
        (e) => RatingParticipantModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$RatingResponseModelToJson(
  RatingResponseModel instance,
) => <String, dynamic>{
  'period_type': _$PeriodTypeEnumMap[instance.periodType]!,
  'area_type': _$AreaTypeEnumMap[instance.areaType]!,
  'owner_data': instance.ownerData,
  'pagination': instance.pagination,
  'list': instance.list,
};

RatingParticipantModel _$RatingParticipantModelFromJson(
  Map<String, dynamic> json,
) => RatingParticipantModel(
  ratingNumber: (json['rating_number'] as num).toInt(),
  fullName: json['full_name'] as String,
  readedPagesCount: (json['readed_pages_count'] as num).toInt(),
  email: json['email'] as String?,
  userName: json['user_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$RatingParticipantModelToJson(
  RatingParticipantModel instance,
) => <String, dynamic>{
  'rating_number': instance.ratingNumber,
  'full_name': instance.fullName,
  'user_name': instance.userName,
  'readed_pages_count': instance.readedPagesCount,
  'email': instance.email,
  'avatar_url': instance.avatarUrl,
  'country': instance.country,
};

RatingPaginationModel _$RatingPaginationModelFromJson(
  Map<String, dynamic> json,
) => RatingPaginationModel(
  currentPage: (json['current_page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  hasNext: json['has_next'] as bool,
);

Map<String, dynamic> _$RatingPaginationModelToJson(
  RatingPaginationModel instance,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'total_pages': instance.totalPages,
  'has_next': instance.hasNext,
};

RatingOwnerModel _$RatingOwnerModelFromJson(Map<String, dynamic> json) => RatingOwnerModel(
  ratingNumber: (json['rating_number'] as num).toInt(),
  readedPagesCount: (json['readed_pages_count'] as num).toInt(),
);

Map<String, dynamic> _$RatingOwnerModelToJson(RatingOwnerModel instance) => <String, dynamic>{
  'rating_number': instance.ratingNumber,
  'readed_pages_count': instance.readedPagesCount,
};

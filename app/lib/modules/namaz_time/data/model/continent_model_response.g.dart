// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContinentModelResponse _$ContinentModelResponseFromJson(
        Map<String, dynamic> json) =>
    ContinentModelResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => Continent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContinentModelResponseToJson(
        ContinentModelResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Continent _$ContinentFromJson(Map<String, dynamic> json) => Continent(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      titleRu: json['titleRu'] as String?,
      titleEn: json['titleEn'] as String?,
      parentId: (json['parentId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ContinentToJson(Continent instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleRu': instance.titleRu,
      'titleEn': instance.titleEn,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

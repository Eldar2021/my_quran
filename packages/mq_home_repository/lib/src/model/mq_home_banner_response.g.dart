// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_home_banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHomeBannerResponse _$MqHomeBannerResponseFromJson(Map<String, dynamic> json) => MqHomeBannerResponse(
      imageRu: json['imageRu'] as String,
      imageEn: json['imageEn'] as String,
      imageKy: json['imageKy'] as String,
      imageTr: json['imageTr'] as String,
      hasCondition: json['hasCondition'] as bool,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$MqHomeBannerResponseToJson(MqHomeBannerResponse instance) => <String, dynamic>{
      'imageRu': instance.imageRu,
      'imageEn': instance.imageEn,
      'imageKy': instance.imageKy,
      'imageTr': instance.imageTr,
      'hasCondition': instance.hasCondition,
      'date': instance.date,
    };

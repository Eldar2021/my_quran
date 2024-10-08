// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModelResponse _$HomeModelResponseFromJson(Map<String, dynamic> json) =>
    HomeModelResponse(
      allDoneHatims: (json['allDoneHatims'] as num).toInt(),
      allDonePages: (json['allDonePages'] as num).toInt(),
      donePages: (json['donePages'] as num).toInt(),
    );

Map<String, dynamic> _$HomeModelResponseToJson(HomeModelResponse instance) =>
    <String, dynamic>{
      'allDoneHatims': instance.allDoneHatims,
      'allDonePages': instance.allDonePages,
      'donePages': instance.donePages,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_home_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHomeModelResponse _$MqHomeModelResponseFromJson(Map<String, dynamic> json) =>
    MqHomeModelResponse(
      allDoneHatims: (json['allDoneHatims'] as num).toInt(),
      allDonePages: (json['allDonePages'] as num).toInt(),
      donePages: (json['donePages'] as num).toInt(),
    );

Map<String, dynamic> _$MqHomeModelResponseToJson(
        MqHomeModelResponse instance) =>
    <String, dynamic>{
      'allDoneHatims': instance.allDoneHatims,
      'allDonePages': instance.allDonePages,
      'donePages': instance.donePages,
    };

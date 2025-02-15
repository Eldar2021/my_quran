// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_story_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqStoryModelResponse _$MqStoryModelResponseFromJson(Map<String, dynamic> json) => MqStoryModelResponse(
  cardImageUrl: json['cardImageUrl'] as String,
  cardLabel: json['cardLabel'] as String,
  isViewed: json['isViewed'] as bool,
  button: MqStoryButtonResponse.fromJson(json['button'] as Map<String, dynamic>),
  screens:
      (json['screens'] as List<dynamic>).map((e) => MqStoryScreenResponse.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$MqStoryModelResponseToJson(MqStoryModelResponse instance) => <String, dynamic>{
  'cardImageUrl': instance.cardImageUrl,
  'cardLabel': instance.cardLabel,
  'isViewed': instance.isViewed,
  'button': instance.button,
  'screens': instance.screens,
};

MqStoryButtonResponse _$MqStoryButtonResponseFromJson(Map<String, dynamic> json) => MqStoryButtonResponse(
  hasButton: json['hasButton'] as bool,
  label: json['label'] as String,
  action: json['action'] as String,
);

Map<String, dynamic> _$MqStoryButtonResponseToJson(MqStoryButtonResponse instance) => <String, dynamic>{
  'hasButton': instance.hasButton,
  'label': instance.label,
  'action': instance.action,
};

MqStoryScreenResponse _$MqStoryScreenResponseFromJson(Map<String, dynamic> json) => MqStoryScreenResponse(
  imageUrl: json['imageUrl'] as String,
  durationByMilliseconds: (json['durationByMilliseconds'] as num).toInt(),
);

Map<String, dynamic> _$MqStoryScreenResponseToJson(MqStoryScreenResponse instance) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  'durationByMilliseconds': instance.durationByMilliseconds,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimCreateModel _$MqHatimCreateModelFromJson(Map<String, dynamic> json) => MqHatimCreateModel(
  title: json['title'] as String,
  description: json['description'] as String,
  type: json['type'] as String,
  participants: (json['participants'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$MqHatimCreateModelToJson(MqHatimCreateModel instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'participants': instance.participants,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqSearchModel _$MqSearchModelFromJson(Map<String, dynamic> json) => MqSearchModel(
  users: (json['users'] as List<dynamic>?)?.map((e) => MqUserIdModel.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$MqSearchModelToJson(MqSearchModel instance) => <String, dynamic>{'users': instance.users};

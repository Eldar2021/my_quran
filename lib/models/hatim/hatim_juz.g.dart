// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatim_juz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimJus _$HatimJusFromJson(Map<String, dynamic> json) => HatimJus(
      id: json['id'] as int,
      name: json['name'] as String,
      emptyPersent: json['emptyPersent'] as num,
      processPersent: json['processPersent'] as num,
      donePercent: json['donePercent'] as num,
    );

Map<String, dynamic> _$HatimJusToJson(HatimJus instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emptyPersent': instance.emptyPersent,
      'processPersent': instance.processPersent,
      'donePercent': instance.donePercent,
    };

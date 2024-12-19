// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_juz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimJus _$HatimJusFromJson(Map<String, dynamic> json) => HatimJus(
      id: json['id'] as String,
      status: json['status'] as String,
      number: (json['number'] as num).toInt(),
      toDo: (json['toDo'] as num).toInt(),
      inProgress: (json['inProgress'] as num).toInt(),
      done: (json['done'] as num).toInt(),
    );

Map<String, dynamic> _$HatimJusToJson(HatimJus instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'number': instance.number,
      'toDo': instance.toDo,
      'inProgress': instance.inProgress,
      'done': instance.done,
    };

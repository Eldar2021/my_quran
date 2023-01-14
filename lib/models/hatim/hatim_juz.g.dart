// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatim_juz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimJus _$HatimJusFromJson(Map<String, dynamic> json) => HatimJus(
      id: json['id'] as String,
      status: json['status'] as String,
      number: json['number'] as int,
      toDo: json['toDo'] as int,
      inProgress: json['inProgress'] as int,
      done: json['done'] as int,
    );

Map<String, dynamic> _$HatimJusToJson(HatimJus instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'number': instance.number,
      'toDo': instance.toDo,
      'inProgress': instance.inProgress,
      'done': instance.done,
    };

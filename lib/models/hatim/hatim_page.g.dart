// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatim_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimPage _$HatimPageFromJson(Map<String, dynamic> json) => HatimPage(
      id: json['id'] as int,
      status: $enumDecode(_$PageStatusEnumMap, json['status']),
      isMy: json['isMy'] as bool,
    );

Map<String, dynamic> _$HatimPageToJson(HatimPage instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$PageStatusEnumMap[instance.status]!,
      'isMy': instance.isMy,
    };

const _$PageStatusEnumMap = {
  PageStatus.empty: 'empty',
  PageStatus.process: 'process',
  PageStatus.done: 'done',
};

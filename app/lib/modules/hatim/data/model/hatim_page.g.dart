// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatim_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimPages _$HatimPagesFromJson(Map<String, dynamic> json) => HatimPages(
      id: json['id'] as String,
      status: $enumDecode(_$HatimPageStatusEnumMap, json['status']),
      number: json['number'] as int,
      mine: json['mine']!= null? json['mine'] as bool: null,
    );

Map<String, dynamic> _$HatimPagesToJson(HatimPages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'status': _$HatimPageStatusEnumMap[instance.status]!,
      'mine': instance.mine,
    };

const _$HatimPageStatusEnumMap = {
  HatimPageStatus.todo: 'TODO',
  HatimPageStatus.booked: 'BOOKED',
  HatimPageStatus.inProgress: 'IN_PROGRESS',
  HatimPageStatus.done: 'DONE',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimPages _$HatimPagesFromJson(Map<String, dynamic> json) => HatimPages(
  id: json['id'] as String,
  status: $enumDecode(_$HatimPageStatusEnumMap, json['status']),
  number: (json['number'] as num).toInt(),
  mine: json['mine'] as bool,
);

Map<String, dynamic> _$HatimPagesToJson(HatimPages instance) => <String, dynamic>{
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

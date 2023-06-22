// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatim_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimPages _$HatimPagesFromJson(Map<String, dynamic> json) => HatimPages(
      id: json['id'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      number: json['number'] as int,
      mine: json['mine'] as bool,
    );

Map<String, dynamic> _$HatimPagesToJson(HatimPages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'status': _$StatusEnumMap[instance.status]!,
      'mine': instance.mine,
    };

const _$StatusEnumMap = {
  Status.todo: 'TODO',
  Status.booked: 'BOOKED',
  Status.inProgress: 'IN_PROGRESS',
  Status.done: 'DONE',
};

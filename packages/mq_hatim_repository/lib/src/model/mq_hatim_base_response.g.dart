// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HatimBaseResponse _$HatimBaseResponseFromJson(Map<String, dynamic> json) => HatimBaseResponse(
      type: $enumDecode(_$HatimResponseTypeEnumMap, json['type']),
      data: json['data'],
    );

Map<String, dynamic> _$HatimBaseResponseToJson(HatimBaseResponse instance) => <String, dynamic>{
      'type': _$HatimResponseTypeEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$HatimResponseTypeEnumMap = {
  HatimResponseType.listOfJuz: 'list_of_juz',
  HatimResponseType.listOfPage: 'list_of_page',
  HatimResponseType.userPages: 'user_pages',
};

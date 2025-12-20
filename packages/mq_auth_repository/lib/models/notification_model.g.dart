// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) => NotificationModel(
  id: json['id'] as String,
  isRead: json['isRead'] as bool,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  title: json['title'] as String,
  description: json['description'] as String,
  date: DateTime.parse(json['date'] as String),
  avatar: json['avatar'] as String?,
  image: json['image'] as String?,
  action: json['action'] == null ? null : NotificationAction.fromJson(json['action'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) => <String, dynamic>{
  'id': instance.id,
  'isRead': instance.isRead,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'avatar': instance.avatar,
  'title': instance.title,
  'description': instance.description,
  'date': instance.date.toIso8601String(),
  'image': instance.image,
  'action': instance.action,
};

const _$NotificationTypeEnumMap = {
  NotificationType.alert: 'ALERT',
  NotificationType.info: 'INFO',
  NotificationType.promo: 'PROMO',
  NotificationType.standard: 'STANDARD',
};

NotificationAction _$NotificationActionFromJson(Map<String, dynamic> json) => NotificationAction(
  buttonText: json['buttonText'] as String,
  isActive: json['isActive'] as bool,
  actionType: $enumDecode(
    _$NotificationActionTypeEnumMap,
    json['actionType'],
  ),
  payload: json['payload'],
);

Map<String, dynamic> _$NotificationActionToJson(NotificationAction instance) => <String, dynamic>{
  'buttonText': instance.buttonText,
  'isActive': instance.isActive,
  'actionType': _$NotificationActionTypeEnumMap[instance.actionType]!,
  'payload': instance.payload,
};

const _$NotificationActionTypeEnumMap = {
  NotificationActionType.openUrl: 'OPEN_URL',
  NotificationActionType.joinToHatim: 'JOIN_TO_HATIM',
};

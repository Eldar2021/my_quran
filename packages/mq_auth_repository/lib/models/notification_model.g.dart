// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) => NotificationModel(
  id: json['id'] as String,
  isRead: json['is_read'] as bool,
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
  'is_read': instance.isRead,
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
  buttonText: json['button_text'] as String,
  isActive: json['is_active'] as bool,
  actionType: $enumDecode(
    _$NotificationActionTypeEnumMap,
    json['action_type'],
  ),
  payload: json['payload'],
);

Map<String, dynamic> _$NotificationActionToJson(NotificationAction instance) => <String, dynamic>{
  'button_text': instance.buttonText,
  'is_active': instance.isActive,
  'action_type': _$NotificationActionTypeEnumMap[instance.actionType]!,
  'payload': instance.payload,
};

const _$NotificationActionTypeEnumMap = {
  NotificationActionType.openUrl: 'OPEN_URL',
  NotificationActionType.joinToHatim: 'JOIN_TO_HATIM',
};

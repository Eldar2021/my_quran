import 'package:flutter/foundation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
@immutable
final class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.isRead,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    this.avatar,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'is_read')
  final bool isRead;
  @JsonKey(name: 'type')
  final NotificationType type;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'image')
  final String? image;

  // @JsonKey(name: 'action')
  // final NotificationAction? action;

  NotificationAction? get action => null;
}

@JsonSerializable()
@immutable
final class NotificationAction {
  const NotificationAction({
    required this.buttonText,
    required this.isActive,
    required this.actionType,
    required this.payload,
  });

  factory NotificationAction.fromJson(Map<String, dynamic> json) => _$NotificationActionFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationActionToJson(this);

  @JsonKey(name: 'button_text')
  final String buttonText;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'action_type')
  final NotificationActionType actionType;
  @JsonKey(name: 'action_payload')
  final dynamic payload;
}

enum NotificationType {
  @JsonValue('ALERT')
  alert,
  @JsonValue('INFO')
  info,
  @JsonValue('PROMO')
  promo,
  @JsonValue('STANDARD')
  standard,
}

enum NotificationActionType {
  @JsonValue('OPEN_URL')
  openUrl,
  @JsonValue('JOIN_TO_HATIM')
  joinToHatim,
}

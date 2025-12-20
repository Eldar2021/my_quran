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
    this.action,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  final String id;
  final bool isRead;
  final NotificationType type;
  final String? avatar;
  final String title;
  final String description;
  final DateTime date;
  final String? image;
  final NotificationAction? action;
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

  final String buttonText;
  final bool isActive;
  final NotificationActionType actionType;
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

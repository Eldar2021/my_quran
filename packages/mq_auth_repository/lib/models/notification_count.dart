import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_count.g.dart';

@JsonSerializable()
@immutable
final class NotificationCount extends Equatable {
  const NotificationCount(this.unreadCount);

  factory NotificationCount.fromJson(Map<String, dynamic> json) => _$NotificationCountFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationCountToJson(this);

  @JsonKey(name: 'unread_count')
  final int unreadCount;

  NotificationCount copyWith(int unreadCount) {
    return NotificationCount(unreadCount);
  }

  @override
  List<Object?> get props => [unreadCount];
}

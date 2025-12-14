part of 'notification_count_cubit.dart';

class NotificationCountState extends Equatable {
  const NotificationCountState({
    this.isNotificationEnabled = false,
    this.notificationCount = 0,
  });

  final bool isNotificationEnabled;
  final int notificationCount;

  NotificationCountState copyWith({
    bool? isNotificationEnabled,
    int? notificationCount,
  }) {
    return NotificationCountState(
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }

  @override
  List<Object> get props => [
    isNotificationEnabled,
    notificationCount,
  ];
}

part of 'notification_cubit.dart';

class NotificationGlobalState extends Equatable {
  const NotificationGlobalState({
    this.fetchState = const NotificationInitial(),
    this.isNotificationEnabled = false,
  });

  final NotificationState fetchState;
  final bool isNotificationEnabled;

  NotificationGlobalState copyWith({
    NotificationState? fetchState,
    bool? isNotificationEnabled,
  }) {
    return NotificationGlobalState(
      fetchState: fetchState ?? this.fetchState,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }

  @override
  List<Object> get props => [
    fetchState,
    isNotificationEnabled,
  ];
}

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

@immutable
final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

final class NotificationSuccess extends NotificationState {
  const NotificationSuccess(this.notifications);

  final List<NotificationModel>? notifications;
}

final class NotificationError extends NotificationState {
  const NotificationError(this.error);

  final Object error;
}

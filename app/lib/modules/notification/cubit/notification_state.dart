part of 'notification_cubit.dart';

class NotificationGlobalState extends Equatable {
  const NotificationGlobalState({
    this.fetchState = const NotificationInitial(),
    this.permissionState = const NotificationPermissionInitial(),
  });

  final NotificationState fetchState;
  final NotificationPermissionState permissionState;

  NotificationGlobalState copyWith({
    NotificationState? fetchState,
    NotificationPermissionState? permissionState,
  }) {
    return NotificationGlobalState(
      fetchState: fetchState ?? this.fetchState,
      permissionState: permissionState ?? this.permissionState,
    );
  }

  @override
  List<Object> get props => [
    fetchState,
    permissionState,
  ];
}

/// Fetch state
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

/// NotificationPermission state
sealed class NotificationPermissionState extends Equatable {
  const NotificationPermissionState();

  @override
  List<Object> get props => [];

  bool get isNotificationEnabled =>
      this is NotificationPermissionSuccess && (this as NotificationPermissionSuccess).isEnabled;
}

final class NotificationPermissionInitial extends NotificationPermissionState {
  const NotificationPermissionInitial();
}

final class NotificationPermissionLoading extends NotificationPermissionState {
  const NotificationPermissionLoading();
}

final class NotificationPermissionSuccess extends NotificationPermissionState {
  const NotificationPermissionSuccess({this.isEnabled = true});

  final bool isEnabled;
}

final class NotificationPermissionError extends NotificationPermissionState {
  const NotificationPermissionError(this.error);

  final Object error;
}

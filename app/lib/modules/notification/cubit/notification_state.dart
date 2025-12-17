part of 'notification_cubit.dart';

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

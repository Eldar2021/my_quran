part of 'notification_cubit.dart';

@immutable
final class NotificationState extends Equatable {
  const NotificationState({
    this.fetchState = const NotificationFetchInitial(),
    this.tokenState = const NotificationTokenInitial(),
    this.allowedState = const NotificationAllowedInitial(false),
  });

  final NoticationFetchState fetchState;
  final NotificaionTokenState tokenState;
  final NotificationAllowedState allowedState;

  NotificationState copyWith({
    NoticationFetchState? fetchState,
    NotificaionTokenState? tokenState,
    NotificationAllowedState? allowedState,
  }) {
    return NotificationState(
      fetchState: fetchState ?? this.fetchState,
      tokenState: tokenState ?? this.tokenState,
      allowedState: allowedState ?? this.allowedState,
    );
  }

  @override
  List<Object> get props => [
    fetchState,
    tokenState,
    allowedState,
  ];
}

/// -------------Fetch state---------------
@immutable
sealed class NoticationFetchState extends Equatable {
  const NoticationFetchState();

  @override
  List<Object?> get props => [];
}

@immutable
final class NotificationFetchInitial extends NoticationFetchState {
  const NotificationFetchInitial();
}

@immutable
final class NotificationFetchLoading extends NoticationFetchState {
  const NotificationFetchLoading();
}

@immutable
final class NotificationHasInitialData extends NoticationFetchState {
  const NotificationHasInitialData(this.data);

  final NotificationModel data;

  @override
  List<Object?> get props => [data];
}

@immutable
final class NotificationFetchSuccess extends NoticationFetchState {
  const NotificationFetchSuccess(this.notifications);

  final List<NotificationModel>? notifications;

  @override
  List<Object?> get props => [
    notifications,
    notifications?.length,
  ];
}

@immutable
final class NotificationFetchError extends NoticationFetchState {
  const NotificationFetchError(this.error);

  final Object error;
}

/// -------------Token state---------------
@immutable
sealed class NotificaionTokenState extends Equatable {
  const NotificaionTokenState();

  @override
  List<Object> get props => [];
}

@immutable
final class NotificationTokenInitial extends NotificaionTokenState {
  const NotificationTokenInitial();
}

@immutable
final class NotificationTokenLoading extends NotificaionTokenState {
  const NotificationTokenLoading();
}

@immutable
final class NotificationTokenSuccess extends NotificaionTokenState {
  const NotificationTokenSuccess(this.token);

  final String? token;
}

@immutable
final class NotificationTokenError extends NotificaionTokenState {
  const NotificationTokenError(this.error);

  final Object error;
}

/// -------------Notification Allowed State---------------
@immutable
sealed class NotificationAllowedState extends Equatable {
  const NotificationAllowedState(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

@immutable
final class NotificationAllowedInitial extends NotificationAllowedState {
  const NotificationAllowedInitial(super.value);
}

@immutable
final class NotificationAllowedLoading extends NotificationAllowedState {
  const NotificationAllowedLoading(super.value);
}

@immutable
final class NotificationAllowedSuccess extends NotificationAllowedState {
  const NotificationAllowedSuccess(super.value);
}

@immutable
final class NotificationAllowedError extends NotificationAllowedState {
  const NotificationAllowedError(super.value, this.error);

  final Object error;
}

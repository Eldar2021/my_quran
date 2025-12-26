part of 'notification_cubit.dart';

@immutable
final class NotificationState extends Equatable {
  const NotificationState({
    this.fetchState = const NotificationFetchInitial(),
    this.tokenState = const NotificationTokenInitial(),
    this.allowedState = const NotificationAllowedInitial(false),
    this.countState = const NotificationCountInitial(),
  });

  final NoticationFetchState fetchState;
  final NotificaionTokenState tokenState;
  final NotificationAllowedState allowedState;
  final NotificationCountState countState;

  NotificationState copyWith({
    NoticationFetchState? fetchState,
    NotificaionTokenState? tokenState,
    NotificationAllowedState? allowedState,
    NotificationCountState? countState,
  }) {
    return NotificationState(
      fetchState: fetchState ?? this.fetchState,
      tokenState: tokenState ?? this.tokenState,
      allowedState: allowedState ?? this.allowedState,
      countState: countState ?? this.countState,
    );
  }

  @override
  List<Object> get props => [
    fetchState,
    tokenState,
    allowedState,
    countState,
  ];
}

/// -------------Count State---------------
@immutable
sealed class NotificationCountState extends Equatable {
  const NotificationCountState();

  int get count {
    if (this is NotificationCountSuccess) {
      final state = this as NotificationCountSuccess;
      return state.data.unreadCount > 99 ? 99 : state.data.unreadCount;
    } else {
      return 0;
    }
  }

  @override
  List<Object?> get props => [count];
}

@immutable
final class NotificationCountInitial extends NotificationCountState {
  const NotificationCountInitial();
}

@immutable
final class NotificationCountLoading extends NotificationCountState {
  const NotificationCountLoading();
}

@immutable
final class NotificationCountSuccess extends NotificationCountState {
  const NotificationCountSuccess(this.data);

  final NotificationCount data;

  @override
  List<Object?> get props => [data];
}

@immutable
final class NotificationCountError extends NotificationCountState {
  const NotificationCountError(this.error);

  final Object error;
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

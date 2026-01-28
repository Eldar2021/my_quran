part of 'user_activity_cubit.dart';

sealed class UserActivityState extends Equatable {
  const UserActivityState();

  @override
  List<Object> get props => [];
}

@immutable
final class UserActivityInitial extends UserActivityState {
  const UserActivityInitial();
}

@immutable
final class UserActivityLoading extends UserActivityState {
  const UserActivityLoading();
}

@immutable
final class UserActivityLoaded extends UserActivityState {
  const UserActivityLoaded(this.activities);

  final List<UserActivityModel> activities;

  @override
  List<Object> get props => [activities];
}

@immutable
final class UserActivityUnauthorized extends UserActivityState {
  const UserActivityUnauthorized();
}

@immutable
final class UserActivityError extends UserActivityState {
  const UserActivityError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

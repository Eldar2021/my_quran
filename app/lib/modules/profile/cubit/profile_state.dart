part of 'profile_cubit.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];

  bool get isLoading => this is ProfileLoading;
}

@immutable
final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

@immutable
final class ProfileLoading extends ProfileState {
  const ProfileLoading(this.type);

  final ProfileLoadingType type;

  @override
  List<Object> get props => [type];
}

@immutable
final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.user);

  final AuthModel user;

  @override
  List<Object> get props => [user];
}

@immutable
final class ProfileLogout extends ProfileState {
  const ProfileLogout();
}

@immutable
final class ProfileDeleted extends ProfileState {
  const ProfileDeleted();
}

@immutable
final class ProfileError extends ProfileState {
  const ProfileError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

part of 'profile_cubit.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
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

  final UserModel user;

  @override
  List<Object> get props => [user];
}

@immutable
final class ProfileError extends ProfileState {
  const ProfileError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

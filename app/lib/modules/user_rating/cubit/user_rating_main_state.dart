part of 'user_rating_main_cubit.dart';

sealed class UserRatingMainState extends Equatable {
  const UserRatingMainState();

  @override
  List<Object> get props => [];
}

@immutable
final class UserRatingMainInitial extends UserRatingMainState {
  const UserRatingMainInitial();
}

@immutable
final class UserRatingMainLoading extends UserRatingMainState {
  const UserRatingMainLoading();
}

@immutable
final class UserRatingMainSuccess extends UserRatingMainState {
  const UserRatingMainSuccess(this.data);

  final UserRatingMainModel data;
}

@immutable
final class UserRatingMainError extends UserRatingMainState {
  const UserRatingMainError(this.error);

  final Object error;
}

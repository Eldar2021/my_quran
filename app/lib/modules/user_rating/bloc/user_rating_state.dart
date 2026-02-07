part of 'user_rating_bloc.dart';

sealed class UserRatingState extends Equatable {
  const UserRatingState();

  @override
  List<Object> get props => [];
}

final class UserRatingInitial extends UserRatingState {}

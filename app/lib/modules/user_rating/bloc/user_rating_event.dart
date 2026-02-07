part of 'user_rating_bloc.dart';

sealed class UserRatingEvent extends Equatable {
  const UserRatingEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class UserRatingFetchNext extends UserRatingEvent {
  const UserRatingFetchNext(this.periodType);

  final PeriodType periodType;
}

@immutable
final class UserRatingRefresh extends UserRatingEvent {
  const UserRatingRefresh(this.periodType);

  final PeriodType periodType;
}

@immutable
final class UserRatingCancel extends UserRatingEvent {
  const UserRatingCancel();
}

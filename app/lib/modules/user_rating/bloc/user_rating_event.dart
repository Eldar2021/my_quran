part of 'user_rating_bloc.dart';

sealed class UserRatingEvent extends Equatable {
  const UserRatingEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class UserRatingFetchNext extends UserRatingEvent {
  const UserRatingFetchNext(this.areaType);

  final AreaType areaType;
}

@immutable
final class UserRatingRefresh extends UserRatingEvent {
  const UserRatingRefresh(this.areaType);

  final AreaType areaType;
}

@immutable
final class UserRatingCancel extends UserRatingEvent {
  const UserRatingCancel();
}

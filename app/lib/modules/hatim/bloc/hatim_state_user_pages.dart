part of 'hatim_bloc.dart';

@immutable
sealed class HatimUserPagesState {
  const HatimUserPagesState();
}

@immutable
final class HatimUserPagesInitial extends HatimUserPagesState {
  const HatimUserPagesInitial();
}

@immutable
final class HatimUserPagesLoading extends HatimUserPagesState {
  const HatimUserPagesLoading();
}

@immutable
final class HatimUserPagesFetched extends HatimUserPagesState {
  const HatimUserPagesFetched(this.data);

  final List<MqHatimPagesEntity> data;
}

@immutable
final class HatimUserPagesFailed extends HatimUserPagesState {
  const HatimUserPagesFailed(this.exception);

  final Exception exception;
}

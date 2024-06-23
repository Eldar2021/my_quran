part of 'hatim_bloc.dart';

@immutable
sealed class HatimJuzPagesState {
  const HatimJuzPagesState();
}

@immutable
final class HatimJuzPagesInitial extends HatimJuzPagesState {
  const HatimJuzPagesInitial();
}

@immutable
final class HatimJuzPagesLoading extends HatimJuzPagesState {
  const HatimJuzPagesLoading();
}

@immutable
final class HatimJuzPagesFetched extends HatimJuzPagesState {
  const HatimJuzPagesFetched(this.data);

  final List<HatimPagesEntity> data;
}

@immutable
final class HatimJuzPagesFailed extends HatimJuzPagesState {
  const HatimJuzPagesFailed(this.exception);

  final Exception exception;
}

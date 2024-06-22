part of 'hatim_bloc.dart';

@immutable
sealed class HatimJuzsState {
  const HatimJuzsState();
}

@immutable
final class HatimJuzsInitial extends HatimJuzsState {
  const HatimJuzsInitial();
}

@immutable
final class HatimJuzsLoading extends HatimJuzsState {
  const HatimJuzsLoading();
}

@immutable
final class HatimJuzsFetched extends HatimJuzsState {
  const HatimJuzsFetched(this.data);

  final List<HatimJus> data;
}

@immutable
final class HatimJuzsFailed extends HatimJuzsState {
  const HatimJuzsFailed(this.exception);

  final Exception exception;
}

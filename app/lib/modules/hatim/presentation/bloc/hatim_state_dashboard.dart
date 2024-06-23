part of 'hatim_bloc.dart';

@immutable
sealed class HatimDashBoardState {
  const HatimDashBoardState();
}

@immutable
final class HatimDashBoardInitial extends HatimDashBoardState {
  const HatimDashBoardInitial();
}

@immutable
final class HatimDashBoardLoading extends HatimDashBoardState {
  const HatimDashBoardLoading();
}

@immutable
final class HatimDashBoardFetched extends HatimDashBoardState {
  const HatimDashBoardFetched(this.data);

  final HatimReadEntity data;
}

@immutable
final class HatimDashBoardFailed extends HatimDashBoardState {
  const HatimDashBoardFailed(this.exception);

  final Exception exception;
}

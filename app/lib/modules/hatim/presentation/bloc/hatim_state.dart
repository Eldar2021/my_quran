part of 'hatim_bloc.dart';

@immutable
final class HatimState extends Equatable {
  const HatimState({
    this.dashBoardState = const HatimDashBoardInitial(),
    this.juzsState = const HatimJuzsInitial(),
    this.juzPagesState = const HatimJuzPagesInitial(),
    this.userPagesState = const HatimUserPagesInitial(),
    this.eventState = const HatimStateInitial(),
  });

  final HatimDashBoardState dashBoardState;
  final HatimJuzsState juzsState;
  final HatimJuzPagesState juzPagesState;
  final HatimUserPagesState userPagesState;
  final HatimEventState eventState;

  HatimState copyWith({
    HatimDashBoardState? dashBoardState,
    HatimJuzsState? juzsState,
    HatimJuzPagesState? juzPagesState,
    HatimUserPagesState? userPagesState,
    HatimEventState? eventState,
  }) {
    return HatimState(
      dashBoardState: dashBoardState ?? this.dashBoardState,
      juzsState: juzsState ?? this.juzsState,
      juzPagesState: juzPagesState ?? this.juzPagesState,
      userPagesState: userPagesState ?? this.userPagesState,
      eventState: eventState ?? this.eventState,
    );
  }

  @override
  List<Object?> get props => [
        dashBoardState,
        juzsState,
        juzPagesState,
        userPagesState,
        eventState,
      ];
}

@immutable
sealed class HatimEventState {
  const HatimEventState();
}

@immutable
final class HatimStateInitial extends HatimEventState {
  const HatimStateInitial();
}

@immutable
final class HatimStateLoading extends HatimEventState {
  const HatimStateLoading();
}

@immutable
final class HatimStateSuccess extends HatimEventState {
  const HatimStateSuccess(this.hatimId);
  final String hatimId;
}

@immutable
final class HatimStateFailed extends HatimEventState {
  const HatimStateFailed(this.exception);

  final Exception exception;
}

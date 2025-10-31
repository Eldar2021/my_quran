part of 'hatim_bloc.dart';

@immutable
final class HatimState extends Equatable {
  const HatimState({
    this.juzsState = const HatimJuzsInitial(),
    this.juzPagesState = const HatimJuzPagesInitial(),
    this.userPagesState = const HatimUserPagesInitial(),
  });

  final HatimJuzsState juzsState;
  final HatimJuzPagesState juzPagesState;
  final HatimUserPagesState userPagesState;

  HatimState copyWith({
    HatimJuzsState? juzsState,
    HatimJuzPagesState? juzPagesState,
    HatimUserPagesState? userPagesState,
  }) {
    return HatimState(
      juzsState: juzsState ?? this.juzsState,
      juzPagesState: juzPagesState ?? this.juzPagesState,
      userPagesState: userPagesState ?? this.userPagesState,
    );
  }

  @override
  List<Object?> get props => [
    juzsState,
    juzPagesState,
    userPagesState,
  ];
}

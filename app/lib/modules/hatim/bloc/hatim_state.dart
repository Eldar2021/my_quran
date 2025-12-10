part of 'hatim_bloc.dart';

@immutable
final class HatimState extends Equatable {
  const HatimState({
    this.juzsState = const HatimJuzsInitial(),
    this.juzPagesState = const HatimJuzPagesInitial(),
    this.userPagesState = const HatimUserPagesInitial(),
    this.connectionState,
  });

  final HatimJuzsState juzsState;
  final HatimJuzPagesState juzPagesState;
  final HatimUserPagesState userPagesState;
  final ConnectionState? connectionState;

  HatimState copyWith({
    HatimJuzsState? juzsState,
    HatimJuzPagesState? juzPagesState,
    HatimUserPagesState? userPagesState,
    ConnectionState? connectionState,
  }) {
    return HatimState(
      juzsState: juzsState ?? this.juzsState,
      juzPagesState: juzPagesState ?? this.juzPagesState,
      userPagesState: userPagesState ?? this.userPagesState,
      connectionState: connectionState ?? this.connectionState,
    );
  }

  @override
  List<Object?> get props => [
    juzsState,
    juzPagesState,
    userPagesState,
    connectionState,
  ];
}

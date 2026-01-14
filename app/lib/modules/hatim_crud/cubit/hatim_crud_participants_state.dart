part of 'hatim_crud_participants_cubit.dart';

@immutable
final class HatimCrudParticipantsState extends Equatable {
  const HatimCrudParticipantsState({
    required this.participants,
    this.searchState = const HatimCrudParticipantsSearchInitial(),
  });

  final List<MqUserIdModel> participants;
  final HatimCrudParticipantsSearchState searchState;

  HatimCrudParticipantsState copyWith({
    List<MqUserIdModel>? participants,
    HatimCrudParticipantsSearchState? searchState,
  }) {
    return HatimCrudParticipantsState(
      participants: participants ?? this.participants,
      searchState: searchState ?? this.searchState,
    );
  }

  @override
  List<Object?> get props => [
    participants,
    searchState,
  ];
}

/// Participant search states
@immutable
sealed class HatimCrudParticipantsSearchState extends Equatable {
  const HatimCrudParticipantsSearchState();

  @override
  List<Object?> get props => [];
}

@immutable
final class HatimCrudParticipantsSearchInitial extends HatimCrudParticipantsSearchState {
  const HatimCrudParticipantsSearchInitial();
}

@immutable
final class HatimCrudParticipantsSearchLoading extends HatimCrudParticipantsSearchState {
  const HatimCrudParticipantsSearchLoading();
}

@immutable
final class HatimCrudParticipantsSearchSuccess extends HatimCrudParticipantsSearchState {
  const HatimCrudParticipantsSearchSuccess(this.data);

  final MqSearchModel? data;

  @override
  List<Object?> get props => [data];
}

@immutable
final class HatimCrudParticipantsSearchError extends HatimCrudParticipantsSearchState {
  const HatimCrudParticipantsSearchError(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

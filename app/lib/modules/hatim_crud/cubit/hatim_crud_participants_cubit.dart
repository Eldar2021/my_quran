import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'hatim_crud_participants_state.dart';

class HatimCrudParticipantsCubit extends Cubit<HatimCrudParticipantsState> {
  HatimCrudParticipantsCubit({
    required this.repository,
    required this.participants,
  }) : super(HatimCrudParticipantsState(participants: participants));

  final MqHatimRepository repository;
  final List<MqUserIdModel> participants;

  Future<void> search(String query) async {
    emit(state.copyWith(searchState: const HatimCrudParticipantsSearchLoading()));
    try {
      final searchResult = await repository.searchParticipants(query);
      final newState = HatimCrudParticipantsSearchSuccess(searchResult);
      emit(state.copyWith(searchState: newState));
    } on Object catch (e) {
      log('HatimCrudParticipantsCubit search:', error: e);
      final newState = HatimCrudParticipantsSearchError(e);
      emit(state.copyWith(searchState: newState));
    }
  }

  void addParticipant(MqUserIdModel participant) {
    emit(
      state.copyWith(
        participants: [...state.participants, participant],
      ),
    );
    if (state.searchState is HatimCrudParticipantsSearchSuccess) {
      final searchState = state.searchState as HatimCrudParticipantsSearchSuccess;
      searchState.data?.users?.removeWhere((p) => p.id == participant.id);
      emit(state.copyWith(searchState: searchState));
    }
  }

  void removeParticipant(MqUserIdModel participant) {
    emit(
      state.copyWith(
        participants: state.participants.where((p) => p.id != participant.id).toList(),
      ),
    );
    if (state.searchState is HatimCrudParticipantsSearchSuccess) {
      final searchState = state.searchState as HatimCrudParticipantsSearchSuccess;
      searchState.data?.users?.add(participant);
      emit(state.copyWith(searchState: searchState));
    }
  }
}

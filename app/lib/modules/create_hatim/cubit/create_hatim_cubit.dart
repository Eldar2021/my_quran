import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/core/enums/fetch_status.dart';

part 'create_hatim_state.dart';

class CreateHatimCubit extends Cubit<CreateHatimState> {
  CreateHatimCubit(this.mqHatimRepository) : super(const CreateHatimState());

  final MqHatimRepository mqHatimRepository;

  Future<void> createHatim(MqHatimCreateModel hatim) async {
    emit(state.copyWith(status: FetchStatus.loading));

    try {
      final response = await mqHatimRepository.createHatim(hatim);
      emit(
        state.copyWith(
          status: FetchStatus.success,
          hatimModel: response,
        ),
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);

      emit(state.copyWith(status: FetchStatus.error, exception: e));
    }
  }

  Future<void> getSearch(String user) async {
    emit(state.copyWith(status: FetchStatus.loading));

    try {
      final response = await mqHatimRepository.getSearch(user);
      emit(
        state.copyWith(
          status: FetchStatus.success,
          searchModel: response,
        ),
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(state.copyWith(status: FetchStatus.error, exception: e));
    }
  }

  Future<void> addParticipant(MqUserIdModel user) async {
    if (!state.selectedUsers.contains(user)) {
      emit(
        state.copyWith(
          selectedUsers: state.selectedUsers + [user],
        ),
      );
    }
  }

  Future<void> removeParticipant(MqUserIdModel user) async {
    emit(
      state.copyWith(
        selectedUsers: state.selectedUsers.where((u) => u.id != user.id).toList(),
      ),
    );
  }

  Future<void> clearSearch() async {
    emit(state.copyWith(status: FetchStatus.initial));
  }
}

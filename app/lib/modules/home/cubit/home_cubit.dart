import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/core/core.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(const HomeState());

  final MqHomeRepository homeRepository;

  Future<void> getData() async {
    try {
      final homeModel = await homeRepository.getData();
      emit(state.copyWith(status: FetchStatus.success, homeModel: homeModel));
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(state.copyWith(status: FetchStatus.error));
    }
  }

  Future<void> hatimAccept(String id) async {
    try {
      await homeRepository.hatimAccept(id);
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  Future<void> hatimReject(String id) async {
    try {
      await homeRepository.hatimReject(id);
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }
}

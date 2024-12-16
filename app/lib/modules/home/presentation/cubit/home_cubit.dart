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
      emit(HomeState(status: FetchStatus.success, homeModel: homeModel));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const HomeState(status: FetchStatus.error));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHomeDataUseCase) : super(const HomeState());

  final GetHomeDataUseCase getHomeDataUseCase;

  Future<void> getData() async {
    try {
      final homeModel = await getHomeDataUseCase.execute();
      emit(HomeState(status: FetchStatus.success, homeModel: homeModel));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const HomeState(status: FetchStatus.error));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHomeDataUseCase) : super(const HomeState());

  final GetHomeDataUseCase getHomeDataUseCase;

  Future<void> getData(String token) async {
    try {
      final homeModel = await getHomeDataUseCase.execute(token);
      emit(HomeState(status: FetchStatus.success, homeModel: homeModel));
    } catch (_) {
      emit(const HomeState(status: FetchStatus.error));
    }
  }
}

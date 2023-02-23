import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.service) : super(const HomeState(FetchStatus.loading));

  final HomeService service;

  Future<void> getData(String token) async {
    final homeModel = await service.getData(token);
    emit(HomeState(FetchStatus.loading, homeModel: homeModel));
  }

  //   void getTotalHatimAndTotalRead() {
  //   final totalHatim = service.getTotalHatim();
  //   final totalRead = service.getTotalRead();
  //   emit(state.copyWith(totalHatim: totalHatim, totalRead: totalRead));
  // }

  // Future<void> setTotalRead(int value) async {
  //   final totalRead = value + (state.totalRead ?? 0);
  //   await service.saveTotalRead(totalRead.toString());
  //   emit(state.copyWith(totalRead: totalRead));
  // }
}

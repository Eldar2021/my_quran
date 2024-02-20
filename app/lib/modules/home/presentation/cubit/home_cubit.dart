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
}

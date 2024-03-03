import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHomeDataUseCase) : super(const HomeState(FetchStatus.loading));
  final GetHomeDataUseCase getHomeDataUseCase;

  Future<void> getData(String token) async {
    try {
      final homeModel = await getHomeDataUseCase.execute(token);
      emit(HomeState(FetchStatus.success, homeModel: homeModel));
    } catch (_) {
      emit(const HomeState(FetchStatus.error));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'home_banners_state.dart';

class HomeBannersCubit extends Cubit<HomeBannersState> {
  HomeBannersCubit(this.repository) : super(const HomeBannersInitial());

  final MqHomeRepository repository;

  Future<void> getBanners() async {
    try {
      if (state is HomeBannersLoading) return;
      emit(const HomeBannersLoading());
      final banners = await repository.getHomeBanners();
      emit(HomeBannersLoaded(banners));
    } on Exception catch (e) {
      emit(HomeBannersError(e.toString()));
    }
  }
}

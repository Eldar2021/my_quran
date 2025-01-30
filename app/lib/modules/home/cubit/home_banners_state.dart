part of 'home_banners_cubit.dart';

@immutable
sealed class HomeBannersState {
  const HomeBannersState();
}

@immutable
final class HomeBannersInitial extends HomeBannersState {
  const HomeBannersInitial();
}

@immutable
final class HomeBannersLoading extends HomeBannersState {
  const HomeBannersLoading();
}

@immutable
final class HomeBannersLoaded extends HomeBannersState {
  const HomeBannersLoaded(this.banners);
  final List<MqHomeBannerEntity> banners;
}

@immutable
final class HomeBannersError extends HomeBannersState {
  const HomeBannersError(this.error);

  final Object error;
}

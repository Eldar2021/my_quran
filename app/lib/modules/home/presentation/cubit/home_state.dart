part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = FetchStatus.loading,
    this.homeModel,
  });

  final HomeModel? homeModel;
  final FetchStatus status;

  @override
  List<Object?> get props => [homeModel, status];
}

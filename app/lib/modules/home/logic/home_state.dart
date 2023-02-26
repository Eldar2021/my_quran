part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(this.status, {this.homeModel});

  final HomeModel? homeModel;
  final FetchStatus status;

  @override
  List<Object?> get props => [homeModel];
}

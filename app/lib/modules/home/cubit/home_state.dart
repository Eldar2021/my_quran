part of 'home_cubit.dart';

@immutable
final class HomeState extends Equatable {
  const HomeState({this.status = FetchStatus.loading, this.homeModel, this.exception});

  final MqHomeModel? homeModel;
  final FetchStatus status;
  final Object? exception;

  @override
  List<Object?> get props => [homeModel, status, exception];

  HomeState copyWith({MqHomeModel? homeModel, Object? exception}) {
    return HomeState(homeModel: homeModel ?? this.homeModel, exception: exception ?? this.exception);
  }
}

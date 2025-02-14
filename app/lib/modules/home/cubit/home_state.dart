part of 'home_cubit.dart';

@immutable
final class HomeState extends Equatable {
  const HomeState({this.status = FetchStatus.loading, this.homeModel});

  final MqHomeEntity? homeModel;
  final FetchStatus status;

  @override
  List<Object?> get props => [homeModel, status];
}

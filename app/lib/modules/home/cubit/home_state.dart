part of 'home_cubit.dart';

@immutable
final class HomeState extends Equatable {
  const HomeState({this.status = FetchStatus.loading, this.homeModel, this.exception, this.hatimsId = ''});

  final MqHomeModel? homeModel;
  final FetchStatus status;
  final Object? exception;
  final String hatimsId;

  @override
  List<Object?> get props => [homeModel, status, exception, hatimsId];

  HomeState copyWith({FetchStatus? status, MqHomeModel? homeModel, Object? exception, String? hatimsId}) {
    return HomeState(
      status: status ?? this.status,
      homeModel: homeModel ?? this.homeModel,
      exception: exception ?? this.exception,
      hatimsId: hatimsId ?? this.hatimsId,
    );
  }
}

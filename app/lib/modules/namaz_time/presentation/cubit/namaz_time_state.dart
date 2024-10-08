part of 'namaz_time_cubit.dart';

@immutable
final class NamazTimeState extends Equatable {
  const NamazTimeState({
    this.status = FetchStatus.loading,
    this.namazTimesModel,
    this.continentsEntity,
    this.regionsEntity,
  });

  final NamazTimesEntity? namazTimesModel;
  final ContinentsEntity? continentsEntity;
  final RegionsEntity? regionsEntity;

  final FetchStatus status;

  @override
  List<Object?> get props => [namazTimesModel, continentsEntity, regionsEntity, status];
}

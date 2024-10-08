import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/modules/namaz_time/domain/usecase/get_regions_usecase.dart';
part 'namaz_time_state.dart';

class NamazTimeCubit extends Cubit<NamazTimeState> {
  NamazTimeCubit(
    this.getNamazTimesUseCase,
    this.getContinentsUseCase,
    this.getRegionsUseCase,
  ) : super(const NamazTimeState());

  final GetNamazTimesUseCase getNamazTimesUseCase;
  final GetContinentsUseCase getContinentsUseCase;
  final GetRegionsUseCase getRegionsUseCase;

  Future<void> getNamazTimes(int placeId) async {
    try {
      final namazTimeModel = await getNamazTimesUseCase.execute(placeId);
      emit(NamazTimeState(status: FetchStatus.success, namazTimesModel: namazTimeModel));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const NamazTimeState(status: FetchStatus.error));
    }
  }

  Future<void> getContinents() async {
    try {
      final continentModel = await getContinentsUseCase.execute();
      emit(NamazTimeState(status: FetchStatus.success, continentsEntity: continentModel));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const NamazTimeState(status: FetchStatus.error));
    }
  }

  Future<void> getRegions(int continentId) async {
    try {
      final regionsModel = await getRegionsUseCase.execute(continentId);
      emit(NamazTimeState(status: FetchStatus.success, regionsEntity: regionsModel));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const NamazTimeState(status: FetchStatus.error));
    }
  }
}

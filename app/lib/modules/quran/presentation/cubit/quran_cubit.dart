import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit({
    required this.getJuzUseCase,
    required this.getSurahsUseCase,
  }) : super(0);

  final GetJuzUseCase getJuzUseCase;
  final GetSurahsUseCase getSurahsUseCase;

  void change(int? val) => emit(val ?? 0);

  List<JuzEntity> getJuz() {
    return getJuzUseCase();
  }

  List<SurahEntity> getSurah() {
    return getSurahsUseCase();
  }
}

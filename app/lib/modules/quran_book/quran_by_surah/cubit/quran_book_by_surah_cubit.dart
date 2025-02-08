import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_book_by_surah_state.dart';

class QuranBookBySurahCubit extends Cubit<QuranBookBySurahState> {
  QuranBookBySurahCubit({
    required this.repository,
    required this.surahNumber,
  }) : super(const QuranBookBySurahInitial());

  final MqQuranRepository repository;
  final int surahNumber;

  Future<void> getData(String quranFmt) async {
    try {
      if (state is QuranBookBySurahLoaded) return;
      emit(const QuranBookBySurahLoading());
      final response = await repository.fetchQuranBySurah(surahNumber, quranFmt);
      emit(QuranBookBySurahLoaded(response));
    } catch (e) {
      emit(QuranBookBySurahError(e.toString()));
    }
  }

  MqSurahEntity getSurahData() {
    final list = repository.getSurahsData();
    final surah = list.firstWhere((e) => e.id == surahNumber);
    return surah;
  }
}

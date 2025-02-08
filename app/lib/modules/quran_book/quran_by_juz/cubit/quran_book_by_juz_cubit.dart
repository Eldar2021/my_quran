import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_book_by_juz_state.dart';

class QuranBookByJuzCubit extends Cubit<QuranBookByJuzState> {
  QuranBookByJuzCubit(this.repository) : super(const QuranBookByJuzInitial());

  final MqQuranRepository repository;

  Future<void> getData(int juzNumber, String quranFmt) async {
    try {
      if (state is QuranBookByJuzLoading) return;
      emit(const QuranBookByJuzLoading());
      final response = await repository.fetchQuranByJuz(juzNumber, quranFmt);
      emit(QuranBookByJuzLoaded(response));
    } catch (e) {
      emit(QuranBookByJuzError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_book_by_page_state.dart';

class QuranBookByPageCubit extends Cubit<QuranBookByPageState> {
  QuranBookByPageCubit(this.repository) : super(const QuranBookByPageInitial());

  final MqQuranRepository repository;

  Future<void> getData(int pageNumber, String quranFmt) async {
    try {
      if (state is QuranBookByPageLoading) return;
      emit(const QuranBookByPageLoading());
      final response = await repository.fetchQuranByPage(pageNumber, quranFmt);
      emit(QuranBookByPageLoaded(response));
    } catch (e) {
      emit(QuranBookByPageError(e.toString()));
    }
  }
}

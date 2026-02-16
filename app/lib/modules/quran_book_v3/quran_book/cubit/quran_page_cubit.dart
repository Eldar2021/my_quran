import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

part 'quran_page_state.dart';

class QuranPageCubit extends Cubit<QuranPageState> {
  QuranPageCubit({
    required this.quranDataRepository,
    required this.quranFontRepository,
  }) : super(const QuranPageInitial());

  final QuranDataRepository quranDataRepository;
  final QuranFontRepository quranFontRepository;

  Future<void> loadPage(int pageNumber, {int? sortSurahNumber}) async {
    if (isClosed) return;
    try {
      emit(const QuranPageLoading());
      final pageData = await quranDataRepository.getVersesByPage(
        pageNumber,
        sortSurahNumber: sortSurahNumber,
      );
      if (isClosed) return;
      try {
        final fontModel = await quranFontRepository.getFontByPage(pageNumber);
        if (isClosed) return;
        emit(QuranPageLoaded(data: pageData, fonts: fontModel));
      } on Object catch (e) {
        if (isClosed) return;
        log('Error Downloading qurah font for page $pageNumber: $e');
        if (!isClosed) emit(QuranPageLoaded(data: pageData));
      }
    } on Object catch (e) {
      log('Error Get quran data by page $pageNumber: $e');
      if (!isClosed) emit(QuranPageError(e));
    }
  }
}

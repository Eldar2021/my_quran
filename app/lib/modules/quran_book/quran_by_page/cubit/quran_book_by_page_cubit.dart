import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_book_by_page_state.dart';

class QuranBookByPageCubit extends Cubit<QuranBookByPageState> {
  QuranBookByPageCubit({required this.repository, required this.pagesNumber}) : super(const QuranBookByPageInitial());

  final MqQuranRepository repository;
  final List<int> pagesNumber;

  Future<QuranDataEntity?> getData(int pageNumber, String quranFmt) async {
    try {
      final response = await repository.fetchQuranByPage(pageNumber, quranFmt);
      return response;
    } on Exception catch (e, s) {
      log('QuranBookByPageCubit getData error: $e\n$s');
      return null;
    }
  }
}

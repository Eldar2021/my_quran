import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

part 'quran_amen_state.dart';

class QuranAmenCubit extends Cubit<QuranAmenState> {
  QuranAmenCubit(this._repository) : super(const QuranAmenInitial());

  final QuranExtraRepository _repository;

  Future<void> amen(
    List<int> pageNumber, {
    String? hatimId,
  }) async {
    emit(const QuranAmenLoading());
    try {
      final result = await _repository.setDonPages(
        status: 'DONE',
        pageNumber: pageNumber,
        hatimId: hatimId,
      );
      emit(QuranAmenSuccess(result));
    } on Object catch (e) {
      log('QuranAmenCubit amen:', error: e);
      emit(QuranAmenError(e));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/models/models.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit(this.juzNumber) : super(const HatimJuzState());

  final int juzNumber;

  void getData() {
    final hatimPages = hatimPageMockDataList[juzNumber - 1].map(HatimPage.fromJson).toList();
    emit(HatimJuzState(pages: hatimPages));
  }
}

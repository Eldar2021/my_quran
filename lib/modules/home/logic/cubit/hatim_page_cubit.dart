import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/models/models.dart';

part 'hatim_page_state.dart';

class HatimPageCubit extends Cubit<HatimPageState> {
  HatimPageCubit(this.juzNumber) : super(const HatimPageState());

  final int juzNumber;

  void getData() {
    final hatimPages = hatimPageMockDataList[juzNumber - 1].map(HatimPage.fromJson).toList();
    emit(HatimPageState(pages: hatimPages));
  }
}

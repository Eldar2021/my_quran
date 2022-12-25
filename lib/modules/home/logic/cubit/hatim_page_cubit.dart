import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/models/models.dart';

part 'hatim_page_state.dart';

class HatimPageCubit extends Cubit<HatimPageState> {
  HatimPageCubit() : super(const HatimPageState());

  final hatimPages = hatimPageMockData.map(HatimPage.fromJson).toList();
}

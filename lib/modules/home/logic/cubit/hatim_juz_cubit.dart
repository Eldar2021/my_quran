import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/models/models.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit() : super(const HatimJuzState());

  final hatimJusData = hatimJuzMockData.map(HatimJus.fromJson).toList();
}

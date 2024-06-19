import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';

part 'hatim_read_state.dart';

class HatimReadCubit extends Cubit<HatimReadState> {
  HatimReadCubit(this.service) : super(const HatimReadState(FetchStatus.loading));

  HatimReadService service;

  Future<String?> getHatim(String token) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final hatim = await service.getHatim(token);
    hatim.fold(
      (left) {
        emit(state.copyWith(status: FetchStatus.error));
        log('Error retrieving Hatim: $left');
      },
      (right) {
        emit(state.copyWith(status: FetchStatus.success, hatim: right));
      },
    );
    return state.hatim?.id;
  }
}

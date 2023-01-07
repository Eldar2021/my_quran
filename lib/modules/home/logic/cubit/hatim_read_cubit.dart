import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

part 'hatim_read_state.dart';

class HatimReadCubit extends Cubit<HatimReadState> {
  HatimReadCubit(this.service) : super(const HatimReadState(FetchStatus.loading, []));

  HatimReadService service;

  Future<void> getHatim(String token) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final hatim = await service.getHatim(token);
    if (hatim != null) {
      emit(state.copyWith(status: FetchStatus.success, hatim: hatim));
    } else {
      emit(state.copyWith(status: FetchStatus.error));
    }
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}

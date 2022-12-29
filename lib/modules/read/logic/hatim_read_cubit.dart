import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/modules/modules.dart';

part 'hatim_read_state.dart';

class HatimReadCubit extends Cubit<HatimReadState> {
  HatimReadCubit(this.storage) : super(const HatimReadState([]));

  final HatimReadService storage;

  List<int> _pages = [];

  void init() {
    _pages = storage.getPages() ?? <int>[];
    emit(HatimReadState(_pages));
  }

  Future<void> setPage(int newPage) async {
    _pages.add(newPage);
    emit(HatimReadState(_pages));
    await storage.setPages(_pages);
  }

  Future<void> removePage(int newPage) async {
    _pages.remove(newPage);
    await storage.setPages(_pages);
    emit(HatimReadState(_pages));
  }
}

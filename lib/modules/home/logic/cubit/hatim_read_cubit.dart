import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hatim_read_state.dart';

class HatimReadCubit extends Cubit<HatimReadState> {
  HatimReadCubit() : super(const HatimReadState([12, 34, 45]));

  // void init() {
  //   emit(const HatimReadState([12, 34, 45]));
  // }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}

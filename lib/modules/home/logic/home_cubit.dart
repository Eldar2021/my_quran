import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  void change(int? val) => emit(val ?? 0);
}

import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(1);

  void change(int v) => v != state ? emit(v) : {};
}

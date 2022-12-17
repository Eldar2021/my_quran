import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<int> {
  LoginCubit() : super(0);

  void change(int v) => v != state ? emit(v) : {};
}

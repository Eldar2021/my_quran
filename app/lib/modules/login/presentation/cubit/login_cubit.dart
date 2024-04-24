import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(0));

  void change(int v) {
    emit(state.copyWith(value: v));
  }

  void checkPrivacyPolicy({required bool isChecked}) {
    emit(state.copyWith(isPrivacyPolicyChecked: isChecked));
  }
}

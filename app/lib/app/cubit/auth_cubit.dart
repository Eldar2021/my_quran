import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(auth: authRepository.initialAuth));

  final AuthRepository authRepository;

  Future<void> setUserData(AuthModel authModel) {
    emit(state.copyWith(auth: authModel));
    return authRepository.saveUser(authModel);
  }

  void updateAuth(AuthModel auth) {
    emit(state.copyWith(auth: auth));
  }

  void uupdateLocale(String locale) {
    emit(state.copyWith(localeForNow: locale));
  }

  void updateGender(Gender gender) {
    emit(state.copyWith(genderForNow: gender));
  }

  bool get isAuthedticated => state.isAuthedticated;
  String get userId => state.auth?.key ?? '';
}

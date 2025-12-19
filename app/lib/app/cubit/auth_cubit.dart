import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.auth) : super(AuthState(auth: auth));

  final AuthModel? auth;

  void updateAuth(AuthModel auth) {
    emit(state.copyWith(auth: auth));
  }

  void clearAuth() => emit(
    AuthState(locale: state.locale, gender: state.gender),
  );

  void uupdateLocale(String locale) {
    emit(state.copyWith(locale: locale));
  }

  void updateGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  bool get isAuthedticated => state.isAuthedticated;
  String get userId => state.auth?.key ?? '';
}

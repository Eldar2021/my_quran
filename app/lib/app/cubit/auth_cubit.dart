import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.storage,
    this.auth,
  }) : super(AuthState(auth: auth));

  final AuthModel? auth;
  final PreferencesStorage storage;

  void init() {
    if (state.auth == null) {
      final locale = storage.readString(key: StorageKeys.localeKey);
      final gender = Gender.fromData(
        storage.readString(key: StorageKeys.genderKey),
      );
      emit(AuthState(locale: locale, gender: gender));
    }
  }

  void updateAuth(AuthModel auth) {
    if (auth.user.language != null) {
      storage.writeString(
        key: StorageKeys.localeKey,
        value: auth.user.language!,
      );
    }

    if (auth.user.gender != null) {
      storage.writeString(
        key: StorageKeys.genderKey,
        value: auth.user.gender!.name,
      );
    }
    emit(state.copyWith(auth: auth));
  }

  void clearAuth() => emit(
    AuthState(locale: state.locale, gender: state.gender),
  );

  void uupdateLocale(String locale) {
    storage.writeString(
      key: StorageKeys.localeKey,
      value: locale,
    );
    emit(state.copyWith(locale: locale));
  }

  void updateGender(Gender gender) {
    storage.writeString(
      key: StorageKeys.genderKey,
      value: gender.name,
    );
    emit(state.copyWith(gender: gender));
  }

  bool get isAuthedticated => state.isAuthedticated;
  String get userId => state.auth?.key ?? '';
}

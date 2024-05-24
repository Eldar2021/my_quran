import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getInitialUserUseCase,
    this.googleSignIn,
    this.appleSignIn,
    this.setGenderUseCase,
  ) : super(AuthState(user: getInitialUserUseCase.call));

  final GetInitialUserUseCase getInitialUserUseCase;
  final GoogleSignInUseCase googleSignIn;
  final AppleSignInUseCase appleSignIn;
  final SetGenderUseCase setGenderUseCase;

  Future<AuthState> signInWithGoogle(String languageCode, Gender gender) async {
    final user = await googleSignIn(languageCode, gender);
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }

  Future<AuthState> signInWithApple(String languageCode, Gender gender) async {
    final user = await appleSignIn(languageCode, gender);
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }

  Future<void> setGender(Gender gender) async {
    await setGenderUseCase(gender);
    emit(state.copyWith(user: state.user?.copyWith(gender: gender)));
  }

  bool get isAuthedticated => state.user != null;
}

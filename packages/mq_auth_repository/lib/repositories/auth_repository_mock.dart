import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

const _authJsonData = <String, dynamic>{
  'key': 'user_key',
  'user': {
    'first_name': 'Test',
    'last_name': 'User',
    'username': 'test_user',
    'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
    'email': 'test_user@gmail.com',
    'country': null,
    'phone_number': null,
    'gender': 'male',
    'language': 'en',
    'can_create_hatim': false,
  },
};

const _userJsonData = <String, dynamic>{
  'first_name': 'Test',
  'last_name': 'User',
  'username': 'test_user',
  'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
  'email': 'test_user@gmail.com',
  'country': null,
  'phone_number': null,
  'gender': 'male',
  'language': 'en',
  'can_create_hatim': false,
};

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  @override
  AuthModel? get initialAuth => null;

  @override
  Future<void> saveUser(AuthModel user) {
    return Future.value();
  }

  @override
  Future<void> loginWithEmail(String email) {
    return Future.value();
  }

  @override
  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<UserModel> patchGender({
    required String userId,
    required Gender gender,
  }) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => UserModel.fromJson(_userJsonData),
    );
  }

  @override
  Future<UserModel> patchLocale({
    required String userId,
    required String localeCode,
  }) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => UserModel.fromJson(_userJsonData),
    );
  }

  @override
  Future<void> deleteAccount() {
    return Future.value();
  }

  @override
  Future<void> logout() {
    return Future.value();
  }
}

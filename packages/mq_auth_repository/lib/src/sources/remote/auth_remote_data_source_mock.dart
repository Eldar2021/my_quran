import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  const AuthRemoteDataSourceMock();

  @override
  Future<void> loginWithEmail(String email) => Future.value();

  static const Map<String, Object?> mockData = {
    'first_name': 'Eldiiar',
    'last_name': 'Almazbek',
    'username': 'eldiiar',
    'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
    'email': 'eldiiaralmazbekov@gmail.com',
    'country': null,
    'phone_number': null,
    'gender': 'FEMALE',
    'language': 'KY',
    'can_create_hatim': true,
  };

  static const Map<String, Object> loginModel = {
    'key': '3d2cda9094f4753c375c49aa5e8e2fbedede2bbe',
    'user': {
      'first_name': 'Eldiiar',
      'last_name': 'Almazbek',
      'username': 'eldiiar',
      'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
      'email': 'eldiiaralmazbekov@gmail.com',
      'country': null,
      'phone_number': null,
      'gender': 'male',
      'language': 'en',
      'can_create_hatim': true,
    },
  };

  @override
  Future<LoginModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) async {
    return LoginModel.fromJson(loginModel);
  }

  @override
  Future<LoginModel> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    return LoginModel.fromJson(loginModel);
  }

  @override
  Future<LoginModel> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    return LoginModel.fromJson(loginModel);
  }

  @override
  Future<UserModel> saveUserData(UserModel userEntity) async {
    return UserModel.fromJson(mockData);
  }

  @override
  Future<UserModel> pathGender({
    required String userId,
    required Gender gender,
  }) async {
    return UserModel.fromJson(mockData);
  }

  @override
  Future<UserModel> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) async {
    return UserModel.fromJson(mockData);
  }

  @override
  Future<void> deleteAccountRemote() => Future.value();

  @override
  Future<void> logoutRemote() => Future.value();
}

import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_either/mq_either.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithEmail(String email);

  Future<Either<UserModelResponse, Exception>> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<Either<UserModelResponse, Exception>> signInWithGoogle(String languageCode, Gender gender);

  Future<Either<UserModelResponse, Exception>> signInWithApple(String languageCode, Gender gender);

  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity);

  Future<Either<UserDataResponse, Exception>> pathGender({required String userId, required Gender gender});

  Future<Either<UserDataResponse, Exception>> pathLocaleCode({required String userId, required String localeCode});

  Future<void> deleteAccountRemote();

  Future<void> logoutRemote();
}

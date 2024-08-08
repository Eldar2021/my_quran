import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithEmail(String email);

  Future<Either<UserModelResponse, Exception>> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<Either<UserModelResponse, Exception>> signInWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<Either<UserModelResponse, Exception>> signInWithApple(
    String languageCode,
    Gender gender,
  );

  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity);

  Future<Either<UserDataResponse, Exception>> pathGender({
    required String userId,
    required Gender gender,
  });

  Future<Either<UserDataResponse, Exception>> pathLocaleCode({
    required String userId,
    required String localeCode,
  });

  Future<void> logoutRemote();
}

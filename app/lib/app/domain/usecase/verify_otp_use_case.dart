import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class VerifyOtpUseCase {
  const VerifyOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    return repository.verifyOtp(
      email: email,
      otp: otp,
      languageCode: languageCode,
      gender: gender,
    );
  }
}

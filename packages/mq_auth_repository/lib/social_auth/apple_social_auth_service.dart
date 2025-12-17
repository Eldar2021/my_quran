import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/models/login_param.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
final class AppleSocialAuthService {
  const AppleSocialAuthService({
    required this.firebaseAuth,
    required this.isIntegrationTest,
  });

  final FirebaseAuth firebaseAuth;
  final bool isIntegrationTest;

  Future<LoginParam> signInWithApple() async {
    if (isIntegrationTest) {
      return const LoginParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    }
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        oauthCredential,
      );

      return LoginParam(
        name: userCredential.user?.displayName ?? '',
        accessToken: userCredential.credential?.accessToken ?? '',
        identityToken: credential.identityToken ?? '',
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    if (isIntegrationTest) return;
    try {
      await firebaseAuth.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> logOut() async {
    if (isIntegrationTest) return;
    try {
      await firebaseAuth.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }
}

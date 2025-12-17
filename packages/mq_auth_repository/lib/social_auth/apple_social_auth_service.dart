import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
final class AppleSocialAuthService {
  const AppleSocialAuthService({
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  Future<(UserCredential, AuthorizationCredentialAppleID)> signInWithApple() async {
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

      return (userCredential, credential);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await firebaseAuth.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_quran/core/core.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
class SoccialAuth {
  const SoccialAuth(this._googleSignIn);

  final GoogleSignIn _googleSignIn;

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final respone = {
        'name': googleUser!.displayName ?? '',
        'accessToken': credential.accessToken,
      };
      return respone;
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

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

      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return (userCredential, credential);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }
}

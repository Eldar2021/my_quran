import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
class SoccialAuth {
  const SoccialAuth(this._googleSignIn);

  final GoogleSignIn _googleSignIn;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      log('Apple Credential: $appleCredential');
      log('Email: ${appleCredential.email}');
      log('Identity Token: ${appleCredential.identityToken}');
      log('Authorization Code: ${appleCredential.authorizationCode}');
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      log('OAuth Credential: $oauthCredential');
      final userCredential = FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return userCredential;
    } catch (e) {
      log(e.toString());
      rethrow;
      // final appleProvider = AppleAuthProvider()
      //   ..addScope('email')
      //   ..addScope('name');
      // if (kIsWeb) {
      //   return FirebaseAuth.instance.signInWithPopup(appleProvider);
      // } else {
      //   return FirebaseAuth.instance.signInWithProvider(appleProvider);
      // }
    }
  }
}

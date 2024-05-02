import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class SoccialAuth {
  const SoccialAuth(this._googleSignIn);

  final GoogleSignIn _googleSignIn;

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider()
      ..addScope('email')
      ..addScope('name');
    if (kIsWeb) {
      return FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      return FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
  }
}

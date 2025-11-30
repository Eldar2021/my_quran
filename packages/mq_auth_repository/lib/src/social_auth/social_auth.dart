import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
class SoccialAuth {
  SoccialAuth({GoogleSignIn? googleSignIn}) : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      // Initialize if not already initialized
      await _googleSignIn.initialize();

      GoogleSignInAccount? googleUser;

      // Check if platform supports authenticate
      if (_googleSignIn.supportsAuthenticate()) {
        // Use event-based authentication
        final completer = Completer<GoogleSignInAccount?>();
        StreamSubscription<dynamic>? subscription;

        subscription = _googleSignIn.authenticationEvents.listen((event) async {
          if (event is GoogleSignInAuthenticationEventSignIn) {
            await subscription?.cancel();
            if (!completer.isCompleted) {
              completer.complete(event.user);
            }
          } else if (event is GoogleSignInAuthenticationEventSignOut) {
            await subscription?.cancel();
            if (!completer.isCompleted) {
              completer.complete(null);
            }
          }
        });

        // Start authentication
        await _googleSignIn.authenticate();

        // Wait for authentication event with timeout
        googleUser = await completer.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () async {
            await subscription?.cancel();
            return null;
          },
        );
      } else {
        // Fallback for platforms that don't support authenticate
        throw UnsupportedError(
          'Google Sign-In authenticate() not supported on this platform',
        );
      }

      if (googleUser == null) {
        return null;
      }

      // Get authentication (idToken)
      final googleAuth = googleUser.authentication;

      // Get client authorization (accessToken) - request default scopes
      final clientAuth = await googleUser.authorizationClient.authorizationForScopes([
        'email',
        'profile',
      ]);

      final credential = GoogleAuthProvider.credential(
        accessToken: clientAuth?.accessToken,
        idToken: googleAuth.idToken,
      );
      final respone = {
        'name': googleUser.displayName ?? '',
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

      final oauthCredential =
          OAuthProvider(
            'apple.com',
          ).credential(
            idToken: credential.identityToken,
            accessToken: credential.authorizationCode,
          );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
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
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.disconnect();
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

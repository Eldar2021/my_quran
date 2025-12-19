import 'dart:async';

import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';

@immutable
final class GoogleSocialAuthService {
  const GoogleSocialAuthService({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.isIntegrationTest,
  });

  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final bool isIntegrationTest;

  Future<LoginParam?> signIn() async {
    if (isIntegrationTest) {
      return const LoginParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    }
    try {
      await googleSignIn.initialize();

      GoogleSignInAccount? googleUser;

      if (googleSignIn.supportsAuthenticate()) {
        final completer = Completer<GoogleSignInAccount?>();
        StreamSubscription<dynamic>? subscription;

        subscription = googleSignIn.authenticationEvents.listen((event) async {
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

        await googleSignIn.authenticate();

        googleUser = await completer.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () async {
            await subscription?.cancel();
            return null;
          },
        );
      } else {
        throw UnsupportedError(
          'Google Sign-In authenticate() not supported on this platform',
        );
      }

      if (googleUser == null) return null;

      final googleAuth = googleUser.authentication;

      final clientAuth = await googleUser.authorizationClient.authorizationForScopes([
        'email',
        'profile',
      ]);

      final credential = GoogleAuthProvider.credential(
        accessToken: clientAuth?.accessToken,
        idToken: googleAuth.idToken,
      );

      return LoginParam(
        name: googleUser.displayName ?? '',
        accessToken: credential.accessToken ?? '',
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
      await googleSignIn.disconnect();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }

  Future<void> logOut() async {
    if (isIntegrationTest) return;
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      rethrow;
    }
  }
}

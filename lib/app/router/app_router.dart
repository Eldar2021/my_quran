import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/modules/modules.dart';

class AppRouter {
  AppRouter(this.authState);

  final AuthState authState;

  late final router = GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: RouterConst.home,
    routes: [
      GoRoute(
        name: 'login',
        path: RouterConst.login,
        builder: (context, state) => const LoginView(),
      ),
      // GoRoute(
      //   path: '/onboarding',
      //   builder: (context, state) => const OnboardingScreen(),
      // ),
      GoRoute(
        name: 'home',
        path: RouterConst.home,
        builder: (context, state) => const HomeView(),
        routes: [
          GoRoute(
            name: 'juz',
            path: RouterConst.juz,
            builder: (context, state) => const JuzView(),
          ),
          GoRoute(
            name: 'profile',
            path: RouterConst.profile,
            builder: (context, state) => const ProfileView(),
          ),
          GoRoute(
            name: 'read',
            path: RouterConst.read,
            builder: (context, state) => const ReadView(),
          ),
          GoRoute(
            name: 'settings',
            path: RouterConst.settings,
            builder: (context, state) => const SettingsView(),
          ),
          GoRoute(
            name: 'surah',
            path: RouterConst.surah,
            builder: (context, state) => const SurahView(),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = authState.user != null;
      final loggingIn = state.subloc == RouterConst.login;
      if (!loggedIn) {
        return loggingIn ? null : RouterConst.login;
      } else {
        return null;
      }
    },
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
  );
}

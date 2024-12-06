import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey1 = GlobalKey<NavigatorState>(debugLabel: 'home');
final _sectionNavigatorKey2 = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _sectionNavigatorKey3 = GlobalKey<NavigatorState>(debugLabel: 'quran-audio');

@immutable
final class AppRouter {
  const AppRouter._({
    required this.isFirstTime,
  });

  factory AppRouter.intance({
    required bool isFirstTime,
  }) {
    return AppRouter._(
      isFirstTime: isFirstTime,
    );
  }

  final bool isFirstTime;

  static const home = 'home';
  static const hatim = 'hatim';
  static const quran = 'quran';
  static const quranAudio = 'quran-audio';

  static const read = 'read';
  static const hatimRead = 'hatim-read';
  static const login = 'login';
  static const loginWihtSoccial = 'login-with-soccial';
  static const verificationCode = 'verification-code';

  static const settingsPage = 'settings';
  static const langSettings = 'lang-settings';
  static const genderSettings = 'gender-settings';
  static const themeSettings = 'theme-settings';
  static const aboutUs = 'about-us';
  static const contactUs = 'contect-us';
  static const developers = 'developers';
  static const devModeView = 'dev-mode-view';

  GoRouter router() {
    return GoRouter(
      initialLocation: isFirstTime ? '/$login' : '/home',
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Init')),
          ),
        ),
        GoRoute(
          path: '/$login',
          name: login,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/$verificationCode/:email',
          name: verificationCode,
          builder: (context, state) {
            final email = state.pathParameters['email'];
            return VerificationCodeView(email: email!);
          },
        ),
        GoRoute(
          path: '/$loginWihtSoccial',
          name: loginWihtSoccial,
          builder: (context, state) => const SignInView(),
        ),
        GoRoute(
          path: '/$devModeView',
          name: devModeView,
          builder: (context, state) => const DevModeView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainView(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKey1,
              routes: [
                GoRoute(
                  path: '/$quran',
                  name: quran,
                  builder: (context, state) => const QuranView(),
                  routes: _quranSubRoutes,
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKey2,
              routes: [
                GoRoute(
                  path: '/$home',
                  name: home,
                  builder: (context, state) => const HomeView(),
                  routes: _homeSubRoutes,
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKey3,
              routes: [
                GoRoute(
                  path: '/$quranAudio',
                  name: quranAudio,
                  builder: (context, state) => const QuranAudioView(),
                ),
              ],
            ),
          ],
        ),
      ],
      // redirect: (context, state) {
      //   final path = state.matchedLocation;
      //   if (!context.read<AuthCubit>().isAuthedticated) {
      //     if (!path.contains(devModeView) && !path.contains(loginWihtSoccial) && !path.contains(verificationCode)) {
      //       return '/$login';
      //     }
      //   }
      //   return null;
      // },
    );
  }

  static List<RouteBase> get _homeSubRoutes {
    return [
      GoRoute(
        path: hatim,
        name: hatim,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const HatimView(),
        routes: [
          GoRoute(
            path: '$hatimRead/:isHatim/:pages',
            name: hatimRead,
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) {
              final args = ParseParams.parseRead(state.pathParameters);
              return ReadView(args.$1, isHatim: args.$2);
            },
          ),
        ],
      ),
      GoRoute(
        path: settingsPage,
        name: settingsPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsView(),
        routes: _settingsSubRoutes,
      ),
    ];
  }

  static List<RouteBase> get _quranSubRoutes {
    return [
      GoRoute(
        path: '$read/:isHatim/:pages',
        name: read,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = ParseParams.parseRead(state.pathParameters);
          return ReadView(args.$1, isHatim: args.$2);
        },
      ),
    ];
  }

  static List<RouteBase> get _settingsSubRoutes {
    return [
      GoRoute(
        path: genderSettings,
        name: genderSettings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const GenderSettingView(),
      ),
      GoRoute(
        path: langSettings,
        name: langSettings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LangSettingsView(),
      ),
      GoRoute(
        path: themeSettings,
        name: themeSettings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ThemeSettingsView(),
      ),
      GoRoute(
        path: aboutUs,
        name: aboutUs,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AboutUsVuew(),
      ),
      GoRoute(
        path: contactUs,
        name: contactUs,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: developers,
        name: developers,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DevelopersView(),
      ),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/src/src.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey1 = GlobalKey<NavigatorState>(debugLabel: 'home');
final _sectionNavigatorKey2 = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _sectionNavigatorKey3 = GlobalKey<NavigatorState>(debugLabel: 'quran-audio');
final _sectionNavigatorKey4 = GlobalKey<NavigatorState>(debugLabel: 'settings');

@immutable
final class AppRouter {
  const AppRouter._();

  static const home = 'home';
  static const hatim = 'hatim';
  static const quran = 'quran';
  static const quranAudio = 'quran-audio';

  static const read = 'read';
  static const hatimRead = 'hatim-read';
  static const login = 'login';

  static const settingsPage = 'settings';
  static const langSettings = 'lang-settings';
  static const genderSettings = 'gender-settings';
  static const themeSettings = 'theme-settings';
  static const aboutUs = 'about-us';
  static const contactUs = 'contect-us';
  static const developers = 'developers';
  static const devModeView = 'dev-mode-view';

  static final router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
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
        path: '/$devModeView',
        name: devModeView,
        builder: (context, state) => const DevModeView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainView(navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey1,
            routes: [
              GoRoute(
                path: '/$home',
                name: home,
                builder: (context, state) => const HomeView(),
                routes: homeSubRoutes,
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey2,
            routes: [
              GoRoute(
                path: '/$quran',
                name: quran,
                builder: (context, state) => const QuranView(),
                routes: quranSubRoutes,
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
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey4,
            routes: [
              GoRoute(
                path: '/$settingsPage',
                name: settingsPage,
                builder: (context, state) => const SettingsView(),
                routes: settingsSubRoutes,
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      return !context.read<AuthCubit>().isAuthedticated ? '/$login' : null;
    },
  );

  static List<RouteBase> get homeSubRoutes {
    return [
      GoRoute(
        path: hatim,
        name: hatim,
        builder: (context, state) => const HatimView(),
        routes: [
          GoRoute(
            path: '$hatimRead/:isHatim/:pages',
            name: hatimRead,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final args = ParseParams.parseRead(state.pathParameters);
              return ReadView(args.$1, isHatim: args.$2);
            },
          ),
        ],
      ),
    ];
  }

  static List<RouteBase> get quranSubRoutes {
    return [
      GoRoute(
        path: '$read/:isHatim/:pages',
        name: read,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final args = ParseParams.parseRead(state.pathParameters);
          return ReadView(args.$1, isHatim: args.$2);
        },
      ),
    ];
  }

  static List<RouteBase> get settingsSubRoutes {
    return [
      GoRoute(
        path: genderSettings,
        name: genderSettings,
        builder: (context, state) => const GenderSettingView(),
      ),
      GoRoute(
        path: langSettings,
        name: langSettings,
        builder: (context, state) => const LangSettingsView(),
      ),
      GoRoute(
        path: themeSettings,
        name: themeSettings,
        builder: (context, state) => const ThemeSettingsView(),
      ),
      GoRoute(
        path: aboutUs,
        name: aboutUs,
        builder: (context, state) => const AboutUsVuew(),
      ),
      GoRoute(
        path: contactUs,
        name: contactUs,
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: developers,
        name: developers,
        builder: (context, state) => const DevelopersView(),
      ),
    ];
  }
}

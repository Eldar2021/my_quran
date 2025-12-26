import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey1 = GlobalKey<NavigatorState>(debugLabel: 'home');
final _sectionNavigatorKey2 = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _sectionNavigatorKey3 = GlobalKey<NavigatorState>(
  debugLabel: 'quran-audio',
);

@immutable
final class AppRouter {
  const AppRouter._({required this.isFirstTime});

  factory AppRouter.intance({required bool isFirstTime}) {
    return AppRouter._(isFirstTime: isFirstTime);
  }

  final bool isFirstTime;

  static const home = 'home';
  static const hatim = 'hatim';
  static const quran = 'quran';
  static const quranAudio = 'quran-audio';
  static const quranBySurah = 'quran-by-surah';
  static const quranByJuz = 'quran-by-juz';
  static const quranByPages = 'quran-by-pages';
  static const hatimRead = 'hatim-read';
  static const notification = 'notification';

  static const login = 'login';
  static const loginWihtSoccial = 'login-with-soccial';

  static const settingsPage = 'settings';
  static const customAppSettings = 'custom-settings';
  static const themeSettings = 'theme-settings';
  static const aboutUs = 'about-us';
  static const contactUs = 'contect-us';
  static const developers = 'developers';
  static const devModeView = 'dev-mode-view';
  static const donation = 'donation';

  static const createHatim = 'create-hatim';
  static const search = 'search';
  static const createHatimSuccess = 'create-hatim-success';

  GoRouter router() {
    return GoRouter(
      initialLocation: isFirstTime ? '/$login' : '/home',
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      observers: [ChuckerFlutter.navigatorObserver],
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
          path: '/$loginWihtSoccial',
          name: loginWihtSoccial,
          builder: (context, state) {
            return BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(context.read<AuthRepository>()),
              child: const SignInView(),
            );
          },
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
    );
  }

  static List<RouteBase> get _homeSubRoutes {
    return [
      GoRoute(
        path: '$hatim/:hatimId',
        name: hatim,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final hatimId = ParseParams.parseHatimId(state.pathParameters);
          return HatimView(hatimId);
        },
        routes: [
          GoRoute(
            path: '$hatimRead/:pages',
            name: hatimRead,
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) {
              final args = ParseParams.parseRead(state.pathParameters);
              return QuranByPagesView(
                pagesNumber: args.$1,
                hatimId: args.$2,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: customAppSettings,
        name: customAppSettings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CustomAppSettingView(),
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
        path: donation,
        name: donation,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MqDonationView(),
      ),
      GoRoute(
        path: developers,
        name: developers,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DevelopersView(),
      ),
      GoRoute(
        path: createHatim,
        name: createHatim,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CreateHatimView(),
      ),
      GoRoute(
        path: search,
        name: search,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        name: createHatimSuccess,
        path: createHatimSuccess,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SuccessView(),
      ),
      GoRoute(
        name: notification,
        path: notification,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => NotificationView(
          state.extra as NotificationModel?,
        ),
      ),
    ];
  }

  static List<RouteBase> get _quranSubRoutes {
    return [
      GoRoute(
        path: '$quranByPages/:pages',
        name: quranByPages,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = ParseParams.parseRead(state.pathParameters);
          return QuranByPagesView(
            pagesNumber: args.$1,
            hatimId: args.$2,
          );
        },
      ),
      GoRoute(
        path: '$quranBySurah/:surahNumber',
        name: quranBySurah,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = ParseParams.parseSurahNumber(state.pathParameters);
          return QuranBySurahView(args);
        },
      ),
      GoRoute(
        path: '$quranByJuz/:juzNumber',
        name: quranByJuz,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = ParseParams.parseJuzNumber(state.pathParameters);
          return QuranByJuzView(args);
        },
      ),
    ];
  }
}

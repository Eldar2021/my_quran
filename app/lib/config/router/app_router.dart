import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKeyMain = GlobalKey<StatefulNavigationShellState>(debugLabel: 'main');
final _sectionNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'home');
final _sectionNavigatorKeyQuran = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _sectionNavigatorKeyQuranAudio = GlobalKey<NavigatorState>(debugLabel: 'quran-audio');
final _sectionNavigatorKeyMore = GlobalKey<NavigatorState>(debugLabel: 'more');

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
  static const appSettings = 'app-settings';
  static const aboutUs = 'about-us';
  static const contactUs = 'contect-us';
  static const developers = 'developers';
  static const devModeView = 'dev-mode-view';
  static const donation = 'donation';
  static const hatimCrud = 'hatim-crud';
  static const hatimParticipants = 'hatim-participants';
  static const more = 'more';
  static const profile = 'profile';

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
          key: sectionNavigatorKeyMain,
          builder: (context, state, navigationShell) {
            return MainView(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKeyHome,
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
              navigatorKey: _sectionNavigatorKeyQuran,
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
              navigatorKey: _sectionNavigatorKeyQuranAudio,
              routes: [
                GoRoute(
                  path: '/$quranAudio',
                  name: quranAudio,
                  builder: (context, state) => const QuranAudioView(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKeyMore,
              routes: [
                GoRoute(
                  path: '/$more',
                  name: more,
                  builder: (context, state) => const MoreView(),
                  routes: _moreSubRoutes,
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
        path: '$hatim/:hatimId/:isCreator',
        name: hatim,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final param = ParseParams.parseHatimId(state.pathParameters);
          return HatimView(param);
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
        name: notification,
        path: notification,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => NotificationView(
          state.extra as NotificationModel?,
        ),
      ),
    ];
  }

  static List<RouteBase> get _moreSubRoutes {
    return [
      GoRoute(
        path: profile,
        name: profile,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: hatimCrud,
        name: hatimCrud,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final param = ParseParams.parseHatimCrud(state.uri.queryParameters);
          return HatimCrudView(param);
        },
        routes: [
          GoRoute(
            path: hatimParticipants,
            name: hatimParticipants,
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => const HatimParticipantsView(),
          ),
        ],
      ),
      GoRoute(
        path: appSettings,
        name: appSettings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AppSettingsView(),
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
      GoRoute(
        path: donation,
        name: donation,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MqDonationView(),
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

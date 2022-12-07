import 'package:flutter/cupertino.dart';

import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class AppRouter {
  const AppRouter();

  static const String home = '/';
  static const String juz = '/juz';
  static const String profile = '/profile';
  static const String read = '/read';
  static const String settingspage = '/settings';
  static const String surah = '/surah';
  static const String login = '/login';

  static Route<void> onGenerateRoute(RouteSettings settings, User? user) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(
          builder: (_) {
            if (user != null) {
              return const HomeView();
            } else {
              return const LoginView();
            }
          },
        );
      case juz:
        return CupertinoPageRoute(
          builder: (_) => const JuzView(),
          settings: settings,
        );
      case surah:
        return CupertinoPageRoute(
          builder: (_) => const SurahView(),
          settings: settings,
        );
      case profile:
        return CupertinoPageRoute(
          builder: (_) => const ProfileView(),
          settings: settings,
        );

      case read:
        final args = settings.arguments!;
        return CupertinoPageRoute(
          builder: (_) => ReadView(args as List<int>),
          settings: settings,
        );

      case settingspage:
        return CupertinoPageRoute(
          builder: (_) => const SettingsView(),
          settings: settings,
        );

      case login:
        return CupertinoPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );
      default:
        throw Exception('no builder specified for route named: [${settings.name}]');
    }
  }
}

import 'package:flutter/cupertino.dart';

import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String home = '/home';
  static const String hatim = '/hatim';
  static const String quran = '/quran';
  static const String read = '/read';
  static const String login = '/login';

  static const String settingsPage = '/settings';
  static const String langSettings = '/lang-settings';
  static const String genderSettings = '/gender-settings';
  static const String themeSettings = '/theme-settings';
  static const String aboutUs = '/about-us';
  static const String developers = '/developers';

  static Route<void> onGenerateRoute(RouteSettings settings, User? user) {
    switch (settings.name) {
      case main:
        return CupertinoPageRoute(
          builder: (_) {
            if (user != null) {
              return const MainView();
            } else {
              return const LoginView();
            }
          },
        );
      case home:
        return CupertinoPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );
      case hatim:
        return CupertinoPageRoute(
          builder: (_) => const HatimView(),
          settings: settings,
        );
      case quran:
        return CupertinoPageRoute(
          builder: (_) => const QuranView(),
          settings: settings,
        );
      case read:
        final args = settings.arguments!;
        return CupertinoPageRoute<bool>(
          builder: (_) => ReadView(
            (args as Map<String, dynamic>)['pages'] as List<int>,
            isHatim: args['isHatim'] as bool,
          ),
          settings: settings,
        );
      case login:
        return CupertinoPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );
      case settingsPage:
        return CupertinoPageRoute(
          builder: (_) => const SettingsView(),
          settings: settings,
        );
      case aboutUs:
        return CupertinoPageRoute(
          builder: (_) => const AboutUsVuew(),
          settings: settings,
        );
      case developers:
        return CupertinoPageRoute(
          builder: (_) => const DevelopersView(),
          settings: settings,
        );
      case genderSettings:
        return CupertinoPageRoute(
          builder: (_) => const GenderSettingView(),
          settings: settings,
        );
      case langSettings:
        return CupertinoPageRoute(
          builder: (_) => const LangSettingsView(),
          settings: settings,
        );
      case themeSettings:
        return CupertinoPageRoute(
          builder: (_) => const ThemeSettingsView(),
          settings: settings,
        );
      default:
        throw Exception('no builder specified for route named: [${settings.name}]');
    }
  }
}

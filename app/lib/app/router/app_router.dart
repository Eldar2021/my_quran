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
  static const String signIn = '/sign-in';

  static const String settingsPage = '/settings';
  static const String langSettings = '/lang-settings';
  static const String genderSettings = '/gender-settings';
  static const String themeSettings = '/theme-settings';
  static const String aboutUs = '/about-us';
  static const String contactUs = '/contect-us';
  static const String developers = '/developers';
  static const String devModeView = '/dev-mode-view';

  static Route<void> onGenerateRoute(RouteSettings settings, User? user) {
    return switch (settings.name) {
      main => CupertinoPageRoute(builder: (_) => user != null ? const MainView() : const LoginView()),
      home => CupertinoPageRoute(builder: (_) => const HomeView()),
      hatim => CupertinoPageRoute(builder: (_) => const HatimView()),
      quran => CupertinoPageRoute(builder: (_) => const QuranView()),
      login => CupertinoPageRoute(builder: (_) => const LoginView()),
      signIn => CupertinoPageRoute(builder: (_) => const SignInView()),
      settingsPage => CupertinoPageRoute(builder: (_) => const SettingsView()),
      aboutUs => CupertinoPageRoute(builder: (_) => const AboutUsVuew()),
      contactUs => CupertinoPageRoute(builder: (_) => const ContactUsView()),
      developers => CupertinoPageRoute(builder: (_) => const DevelopersView()),
      genderSettings => CupertinoPageRoute(builder: (_) => const GenderSettingView()),
      langSettings => CupertinoPageRoute(builder: (_) => const LangSettingsView()),
      themeSettings => CupertinoPageRoute(builder: (_) => const ThemeSettingsView()),
      devModeView => CupertinoPageRoute(builder: (_) => const DevModeView()),
      read => CupertinoPageRoute<bool>(
          builder: (_) {
            final args = settings.arguments!;
            return ReadView(
              (args as Map<String, dynamic>)['pages'] as List<int>,
              isHatim: args['isHatim'] as bool,
            );
          },
        ),
      _ => throw Exception('no builder specified for route named: [${settings.name}]'),
    };
  }
}

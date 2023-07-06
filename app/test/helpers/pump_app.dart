import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    AppService appService,
    ThemeService themeService,
    AuthService authStorage,
    HomeService homeService,
  ) {
    return pumpWidget(
      RepositoryProvider(
        create: (context) => const AppConfig(isIntegrationTest: true),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppCubit(appService, themeService)),
            BlocProvider(create: (context) => AuthCubit(authStorage)),
            BlocProvider(create: (context) => HomeCubit(homeService)),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

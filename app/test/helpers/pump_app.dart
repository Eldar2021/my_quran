import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    GetCurrentLocaleUseCase getLocalLocaleUseCase,
    SetLocaleUseCase setLocaleUseCase,
    GetAppInitialThemeUseCase getInitialThemeUseCase,
    SetModeUseCase setModeUseCase,
    SetColorUseCase setColorUseCase,
    GetInitialUserUseCase getInitialUserUseCase,
    GetAppVersionUseCase getAppVersionUseCase,
    GoogleSignInUseCase loginUseCase,
    SetGenderUseCase setGenderUseCase,
    HomeRepository homeRepo,
  ) {
    return pumpWidget(
      RepositoryProvider(
        create: (context) => const AppConfig(isIntegrationTest: true),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppCubit(
                getLocalLocaleUseCase: getLocalLocaleUseCase,
                setLocaleUseCase: setLocaleUseCase,
                getInitialThemeUseCase: getInitialThemeUseCase,
                setModeUseCase: setModeUseCase,
                setColorUseCase: setColorUseCase,
                getAppVersionUseCase: getAppVersionUseCase,
              ),
            ),
            BlocProvider(
              create: (context) => AuthCubit(
                getInitialUserUseCase,
                loginUseCase,
                setGenderUseCase,
              ),
            ),
            BlocProvider(
              create: (context) => HomeCubit(GetHomeDataUseCase(homeRepo)),
            ),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

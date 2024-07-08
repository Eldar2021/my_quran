import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    GetAppInitialThemeUseCase getInitialThemeUseCase,
    SetModeUseCase setModeUseCase,
    SetColorUseCase setColorUseCase,
    GetInitialUserUseCase getInitialUserUseCase,
    GetAppVersionUseCase getAppVersionUseCase,
    GoogleSignInUseCase googleSignInUseCase,
    AppleSignInUseCase appleSignInUseCase,
    SerUserDataUseCase setUserDataUseCase,
    HomeRepository homeRepo,
    PatchGenderUseCase patchGenderUseCase,
    PatchLocaleCodeUseCase patchLocaleCodeUseCase,
    LogoutUseCase logoutUseCase,
    MqRemoteConfig remoteConfig,
  ) {
    return pumpWidget(
      RepositoryProvider(
        create: (context) => const AppConfig(isIntegrationTest: true),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppCubit(
                getInitialThemeUseCase: getInitialThemeUseCase,
                setModeUseCase: setModeUseCase,
                setColorUseCase: setColorUseCase,
                getAppVersionUseCase: getAppVersionUseCase,
              ),
            ),
            BlocProvider(
              create: (context) => AuthCubit(
                getInitialUserUseCase,
                googleSignInUseCase,
                appleSignInUseCase,
                setUserDataUseCase,
                patchGenderUseCase,
                patchLocaleCodeUseCase,
                logoutUseCase,
              ),
            ),
            BlocProvider(
              create: (context) => HomeCubit(GetHomeDataUseCase(homeRepo)),
            ),
            BlocProvider(
              create: (context) => RemoteConfigCubit(),
            ),
            RepositoryProvider<MqRemoteConfig>(create: (context) => remoteConfig),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

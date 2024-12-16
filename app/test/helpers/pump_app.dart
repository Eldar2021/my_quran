import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_config/mq_remote_config.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    MqHomeRepository homeRepo,
    PatchGenderUseCase patchGenderUseCase,
    PatchLocaleCodeUseCase patchLocaleCodeUseCase,
    LogoutUseCase logoutUseCase,
    MqRemoteConfig remoteConfig,
    PackageInfo packageInfo,
    EmailLoginUseCase emailSignIn,
    VerifyOtpUseCase verifyOtp,
    DeleteAccountUseCase deleteAccount,
  ) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => const AppConfig(isIntegrationTest: true)),
          RepositoryProvider<MqRemoteConfig>(create: (context) => remoteConfig),
        ],
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
                emailSignIn,
                verifyOtp,
                deleteAccount,
              ),
            ),
            BlocProvider(
              create: (context) => HomeCubit(homeRepo),
            ),
            BlocProvider(
              create: (context) => RemoteConfigCubit(
                packageInfo: packageInfo,
                remoteConfig: remoteConfig,
              ),
            ),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

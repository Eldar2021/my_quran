import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(
            AppLocalDataSource(
              packageInfo: context.read<PackageInfo>(),
            ),
          ),
        ),
        RepositoryProvider<ThemeRepository>(
          create: (context) => ThemeRepositoryImpl(
            ThemeLocalDataSource(context.read<PreferencesStorage>()),
          ),
        ),
        BlocProvider(
          create: (context) => AppCubit(
            getInitialThemeUseCase: GetAppInitialThemeUseCase(context.read<ThemeRepository>()),
            setModeUseCase: SetModeUseCase(context.read<ThemeRepository>()),
            setColorUseCase: SetColorUseCase(context.read<ThemeRepository>()),
            getAppVersionUseCase: GetAppVersionUseCase(context.read<AppRepository>()),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            localDataSource: AuthLocalDataSource(
              context.read<PreferencesStorage>(),
            ),
            remoteDataSource: AuthRemoteDataSource(
              client: context.read<RemoteClient>(),
              storage: context.read<PreferencesStorage>(),
              soccialAuth: context.read<SoccialAuth>(),
              isIntegrationTest: context.read<AppConfig>().isIntegrationTest,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            GetInitialUserUseCase(context.read<AuthRepository>()),
            GoogleSignInUseCase(context.read<AuthRepository>()),
            AppleSignInUseCase(context.read<AuthRepository>()),
            SerUserDataUseCase(context.read<AuthRepository>()),
            PatchGenderUseCase(context.read<AuthRepository>()),
            PatchLocaleCodeUseCase(context.read<AuthRepository>()),
            LogoutUseCase(context.read<AuthRepository>()),
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            GetHomeDataUseCase(
              HomeRepositoryImpl(
                HomeLocalDataSource(context.read<PreferencesStorage>()),
                HomeRemoteDataSource(context.read<RemoteClient>()),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => QuranAudioCubit(
            AudioPlayer(),
            context.read<NetworkClient>(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => RemoteConfigCubit(),
        ),
      ],
      child: const QuranApp(),
    );
  }
}

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listenRemoteConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: AppListener(
        navigationKey: rootNavigatorKey,
        child: MaterialApp.router(
          title: 'MyQuranKhatm',
          debugShowCheckedModeBanner: false,
          locale: context.watch<AuthCubit>().state.currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: context.watch<AppCubit>().state.theme.themeData,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }

  void _listenRemoteConfig() {
    final remoteConfig = context.read<MqRemoteConfig>();
    context.read<RemoteConfigCubit>().setAppVersionStatus(
          requiredBuildNumber: remoteConfig.requiredBuildNumber,
          recommendedBuildNumber: remoteConfig.recommendedBuildNumber,
          currentBuildNumber: remoteConfig.currentBuildNumber,
        );

    remoteConfig.remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.remoteConfig.activate();
      setState(() {});
    });
  }
}

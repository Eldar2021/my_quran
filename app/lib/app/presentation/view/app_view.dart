import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
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
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            GetInitialUserUseCase(context.read<AuthRepository>()),
            GoogleSignInUseCase(context.read<AuthRepository>()),
            AppleSignInUseCase(context.read<AuthRepository>()),
            SerUserDataUseCase(context.read<AuthRepository>()),
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
      ],
      child: const QuranApp(),
    );
  }
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyQuranKhatm',
      debugShowCheckedModeBanner: false,
      locale: context.watch<AuthCubit>().state.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: context.watch<AppCubit>().state.theme.themeData,
      routerConfig: AppRouter.router,
    );
  }
}

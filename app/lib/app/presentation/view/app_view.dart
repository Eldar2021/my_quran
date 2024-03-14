import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(
            AppLocalDataSource(context.read<PreferencesStorage>()),
          ),
        ),
        RepositoryProvider<ThemeRepository>(
          create: (context) => ThemeRepositoryImpl(
            ThemeLocalDataSource(context.read<PreferencesStorage>()),
          ),
        ),
        BlocProvider(
          create: (context) => AppCubit(
            getLocalLocaleUseCase: GetCurrentLocaleUseCase(context.read<AppRepository>()),
            setLocaleUseCase: SetLocaleUseCase(context.read<AppRepository>()),
            getInitialThemeUseCase: GetAppInitialThemeUseCase(context.read<ThemeRepository>()),
            setModeUseCase: SetModeUseCase(context.read<ThemeRepository>()),
            setColorUseCase: SetColorUseCase(context.read<ThemeRepository>()),
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
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            GetInitialUserUseCase(context.read<AuthRepository>()),
            LoginUseCase(context.read<AuthRepository>()),
            SetGenderUseCase(context.read<AuthRepository>()),
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
      locale: context.watch<AppCubit>().state.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: context.watch<AppCubit>().state.theme.themeData,
      routerConfig: AppRouter.router,
    );
  }
}

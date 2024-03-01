import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app_imports.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(
            AppService(context.read<PreferencesStorage>()),
            ThemeService(context.read<PreferencesStorage>()),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            AuthService(
              context.read<PreferencesStorage>(),
              context.read<RemoteClient>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            GetHomeDataUseCase(
              HomeRepositoryImpl(
                context.read<HomeLocalDataSource>(),
                context.read<HomeRemoteDataSource>(),
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

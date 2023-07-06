import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/locator.dart';
import 'package:my_quran/modules/modules.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit(sl<AppService>(), sl<ThemeService>())),
        BlocProvider(create: (context) => AuthCubit(sl<AuthService>())),
        BlocProvider(create: (context) => HomeCubit(sl<HomeService>())),
      ],
      child: const _QuranApp(),
    );
  }
}

class _QuranApp extends StatelessWidget {
  const _QuranApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyQuranKhatm',
      debugShowCheckedModeBanner: false,
      locale: context.watch<AppCubit>().state.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: context.watch<AppCubit>().state.theme.themeData,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
        settings,
        context.read<AuthCubit>().state.user,
      ),
    );
  }
}

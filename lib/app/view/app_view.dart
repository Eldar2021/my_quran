import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/modules/modules.dart';
import 'package:hatim/theme/custom/custom_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          locale: context.watch<AppCubit>().state.currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: appThemeData[state.theme]!.toTheme,
          debugShowCheckedModeBanner: false,
          home: const SettingView(),
        );
      },
    );
  }
}

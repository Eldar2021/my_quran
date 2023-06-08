import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/locator.dart';
import 'package:my_quran/modules/modules.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('onCreate(${bloc.state})');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('onClose(${bloc.runtimeType})');
  }
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final storage = await PreferencesStorage.getInstance();

  setup(storage);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit(sl<AppService>(), sl<ThemeService>())),
        BlocProvider(create: (context) => AuthCubit(sl<AuthService>())),
        BlocProvider(create: (context) => HomeCubit(sl<HomeService>())),
      ],
      child: const MyApp(),
    ),
  );

  // await runZonedGuarded(
  //   () async => runApp(
  //     MultiBlocProvider(
  //       providers: [
  //         BlocProvider(create: (context) => AppCubit(sl<AppService>(), sl<ThemeService>())),
  //         BlocProvider(create: (context) => AuthCubit(sl<AuthService>())),
  //         BlocProvider(create: (context) => HomeCubit(sl<HomeService>())),
  //       ],
  //       child: const MyApp(),
  //     ),
  //   ),
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}

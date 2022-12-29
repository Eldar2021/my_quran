import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/modules/modules.dart';

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

  final dr = await getApplicationDocumentsDirectory();
  Hive.init(dr.path);

  final boxData = await Hive.openBox<String>('data');
  final boxApp = await Hive.openBox<String>('app');
  final boxPages = await Hive.openBox<List<int>>('pages');

  setup(boxData, boxApp, boxPages);

  await runZonedGuarded(
    () async => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit(sl<LocalService>(), sl<ThemeService>())),
          BlocProvider(create: (context) => AuthCubit(sl<AuthStorage>())),
          BlocProvider(create: (context) => HatimReadCubit(sl<HatimReadService>())..init()),
          BlocProvider(create: (context) => TimeCubit()..change()),
        ],
        child: const MyApp(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

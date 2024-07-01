import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/app_observer.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main({AppConfig? appConfig}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',
  );

  Bloc.observer = const AppBlocObserver(onLog: log);
  final storage = await PreferencesStorage.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  appConfig ??= AppConfig(storage: storage);

  appConfig.init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppConfig>(create: (context) => appConfig!),
        RepositoryProvider<PreferencesStorage>(create: (context) => storage),
        RepositoryProvider<PackageInfo>(create: (context) => packageInfo),
        RepositoryProvider<NetworkClient>(
          create: (context) => NetworkClient(Connectivity()),
        ),
        RepositoryProvider<RemoteClient>(
          create: (context) => RemoteClient(Client(), context.read<NetworkClient>()),
        ),
        RepositoryProvider<SoccialAuth>(
          create: (context) => SoccialAuth(GoogleSignIn()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

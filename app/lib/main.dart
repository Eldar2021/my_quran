import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/app_observer.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';

Future<void> main({AppConfig? appConfig}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',
  );

  Bloc.observer = AppBlocObserver();
  final storage = await PreferencesStorage.getInstance();

  appConfig ??= AppConfig(storage: storage);

  appConfig.init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => appConfig),
        RepositoryProvider(create: (context) => storage),
        RepositoryProvider(create: (context) => NetworkClient(Connectivity())),
        RepositoryProvider(
          create: (context) => RemoteClient(Client(), context.read<NetworkClient>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

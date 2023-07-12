import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/app_observer.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/locator.dart';

Future<void> main({AppConfig appConfig = const AppConfig()}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  Bloc.observer = AppBlocObserver();
  final storage = await PreferencesStorage.getInstance();

  setup(storage);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => appConfig),
      ],
      child: const MyApp(),
    ),
  );
}

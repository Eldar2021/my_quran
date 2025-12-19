import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_remote_config/mq_remote_config.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/app_observer.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/firebase_options.dart';

Future<void> main({bool isIntegrationTest = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      log('Firebase already initialized');
    }
  } on Object catch (e) {
    log('Firebase Init Error (Ignoring): $e');
  }

  await MqAnalytic.setAnalyticsCollectionEnabled(
    enabled: kReleaseMode,
  );

  await MqCrashlytics.setCrashlyticsCollectionEnabled(
    enabled: kReleaseMode,
  );

  FlutterError.onError = MqCrashlytics.recordFlutterError;

  PlatformDispatcher.instance.onError = (error, stack) {
    MqCrashlytics.report(error, stack, fatal: true);
    return true;
  };

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
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

  final remoteConfig = MqRemoteConfig(
    packageInfo: packageInfo,
  );

  await remoteConfig.initialise();

  final appConfig = AppConfig(
    isIntegrationTest: isIntegrationTest,
    storage: storage,
  );

  final domain = appConfig.isDevMode ? appConfig.devDomain : ApiConst.domain;

  final netWorkClient = NetworkClient();

  final remoteClient = MqRemoteClient(
    dio: Dio(BaseOptions(baseUrl: domain)),
    network: netWorkClient,
    language: () => storage.readString(key: StorageKeys.localeKey),
    token: () => storage.readString(key: StorageKeys.tokenKey),
  )..initilize();

  final localNotificationService = LocalNotificationService(
    FlutterLocalNotificationsPlugin(),
  );

  final firebaseNotificationService = FirebaseNotificationService(
    firebaseMessaging: FirebaseMessaging.instance,
    onShowNotification: localNotificationService.showNotification,
  );

  final notificationService = NotificationService(
    firebase: firebaseNotificationService,
    local: localNotificationService,
    isIntegrationTesting: isIntegrationTest,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppConfig>(
          create: (context) => appConfig,
        ),
        RepositoryProvider<PreferencesStorage>(
          create: (context) => storage,
        ),
        RepositoryProvider<PackageInfo>(
          create: (context) => packageInfo,
        ),
        RepositoryProvider<NetworkClient>(
          create: (context) => netWorkClient,
        ),
        RepositoryProvider<MqRemoteConfig>(
          create: (context) => remoteConfig,
        ),
        RepositoryProvider<NotificationService>(
          create: (context) => notificationService,
        ),
        RepositoryProvider<MqRemoteClient>(
          create: (context) => remoteClient,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

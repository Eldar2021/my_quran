import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_remote_config/mq_remote_config.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isMockData = context.read<AppConfig>().isMockData;
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(
            isMockData
                ? const AppLocalDataSourceMock()
                : AppLocalDataSourceImpl(
                    packageInfo: context.read<PackageInfo>(),
                    storage: context.read<PreferencesStorage>(),
                  ),
          ),
        ),
        RepositoryProvider<MqHomeRepository>(
          create: (context) => MqHomeRepositoryImpl(
            isMockData
                ? const MqHomeLocalDataSourceMock()
                : MqHomeLocalDataSourceImpl(context.read<PreferencesStorage>()),
            isMockData
                ? const MqHomeRemoteDataSourceMock()
                : MqHomeRemoteDataSourceImpl(context.read<MqRemoteClient>()),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(
              localDataSource: isMockData
                  ? const AuthLocalDataSourceMock()
                  : AuthLocalDataSourceImpl(context.read<PreferencesStorage>()),
              remoteDataSource: isMockData
                  ? const AuthRemoteDataSourceMock()
                  : AuthRemoteDataSourceImpl(
                      client: context.read<MqRemoteClient>(),
                      storage: context.read<PreferencesStorage>(),
                      soccialAuth: SoccialAuth(),
                      isIntegrationTest: context.read<AppConfig>().isIntegrationTest,
                    ),
            );
          },
        ),
        BlocProvider(
          create: (context) => AuthCubit(context.read<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(context.read<MqHomeRepository>()),
        ),
        BlocProvider(
          create: (context) => MqStoryCubit(context.read<MqHomeRepository>()),
        ),
        BlocProvider(
          create: (context) => QuranAudioCubit(
            AudioPlayer(),
            context.read<NetworkClient>(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => RemoteConfigCubit(
            packageInfo: context.read<PackageInfo>(),
            remoteConfig: context.read<MqRemoteConfig>(),
          ),
        ),
        BlocProvider(
          create: (context) => LocationCubit(
            context.read<AppConfig>(),
          ),
        ),
        BlocProvider(
          create: (context) => AppThemeCubit(
            context.read<AppRepository>(),
          ),
        ),
      ],
      child: const QuranApp(),
    );
  }
}

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = AppRouter.intance(
      isFirstTime: !context.read<AuthCubit>().isAuthedticated,
    ).router();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RemoteConfigCubit>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: AppListener(
        navigationKey: rootNavigatorKey,
        child: MaterialApp.router(
          title: 'My Quran',
          debugShowCheckedModeBanner: false,
          locale: context.watch<AuthCubit>().state.currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: context.watch<AppThemeCubit>().state.themeData,
          routerConfig: _router,
        ),
      ),
    );
  }
}

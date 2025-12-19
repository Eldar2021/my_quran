import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_config/mq_remote_config.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    AppRepository appRepository,
    AuthRepository authRepository,
    MqHomeRepository homeRepo,
    MqRemoteConfig remoteConfig,
    PreferencesStorage storage,
  ) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AppConfig(
              isIntegrationTest: true,
              storage: storage,
            ),
          ),
          RepositoryProvider<MqRemoteConfig>(
            create: (context) => remoteConfig,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppThemeCubit(appRepository),
            ),
            BlocProvider(
              create: (context) => AuthCubit(
                auth: authRepository.initialAuth,
                storage: storage,
              ),
            ),
            BlocProvider(
              create: (context) => HomeCubit(homeRepo),
            ),
            BlocProvider(
              create: (context) => RemoteConfigCubit(remoteConfig),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(authRepository),
            ),
            BlocProvider(
              create: (context) => NotificationCubit(authRepository),
            ),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

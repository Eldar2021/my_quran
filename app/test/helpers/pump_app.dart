import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_config/mq_remote_config.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    AppRepository appRepository,
    AuthRepository authRepository,
    MqHomeRepository homeRepo,
    MqRemoteConfig remoteConfig,
    PackageInfo packageInfo,
  ) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => const AppConfig(isIntegrationTest: true)),
          RepositoryProvider<MqRemoteConfig>(create: (context) => remoteConfig),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppCubit(appRepository),
            ),
            BlocProvider(
              create: (context) => AuthCubit(authRepository),
            ),
            BlocProvider(
              create: (context) => HomeCubit(homeRepo),
            ),
            BlocProvider(
              create: (context) => RemoteConfigCubit(
                packageInfo: packageInfo,
                remoteConfig: remoteConfig,
              ),
            ),
          ],
          child: const QuranApp(),
        ),
      ),
    );
  }
}

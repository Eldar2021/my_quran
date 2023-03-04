import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

final sl = GetIt.I;

void setup(PreferencesStorage preferencesStorage) {
  sl
    ..registerLazySingleton<AuthService>(() => AuthService(preferencesStorage, sl<RemoteClient>()))
    ..registerLazySingleton<AppService>(() => AppService(preferencesStorage))
    ..registerLazySingleton<ThemeService>(() => ThemeService(preferencesStorage))
    ..registerLazySingleton<HomeService>(() => HomeService(preferencesStorage, sl<RemoteClient>()))
    ..registerLazySingleton<ReadThemeService>(() => ReadThemeService(preferencesStorage))
    ..registerLazySingleton<NetworkClient>(() => NetworkClient(Connectivity()))
    ..registerLazySingleton<RemoteClient>(() => RemoteClient(Client(), networkClient: sl<NetworkClient>()))
    ..registerLazySingleton<HatimReadService>(() => HatimReadService(sl<RemoteClient>()))
    ..registerFactory<ReadService>(() => ReadService(sl<RemoteClient>(), preferencesStorage));
}

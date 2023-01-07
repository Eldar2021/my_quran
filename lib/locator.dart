import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/modules/modules.dart';

final sl = GetIt.I;

void setup(Box<String> boxData, Box<String> boxApp, Box<int> boxReadTheme) {
  sl
    ..registerLazySingleton<AppCache<String>>(() => AppCache(boxApp))
    ..registerLazySingleton<AppCache<int>>(() => AppCache(boxReadTheme))
    ..registerLazySingleton<AuthService>(() => AuthService(sl<AppCache<String>>(), sl<RemoteClient>()))
    ..registerLazySingleton<AppService>(() => AppService(sl<AppCache<String>>()))
    ..registerLazySingleton<ThemeService>(() => ThemeService(sl<AppCache<String>>()))
    ..registerLazySingleton<HomeService>(() => HomeService(sl<LocalClient<String>>(), sl<RemoteClient>()))
    ..registerLazySingleton<ReadThemeService>(() => ReadThemeService(sl<AppCache<int>>()))
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<RemoteClient>(() => RemoteClient(Client()))
    ..registerLazySingleton<LocalClient<String>>(() => LocalClient(boxData))
    ..registerLazySingleton<HatimReadService>(() => HatimReadService(sl<RemoteClient>()))
    ..registerFactory<ReadService>(() => ReadService(sl<RemoteClient>(), sl<LocalClient<String>>()));
}

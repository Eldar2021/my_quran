import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
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
    ..registerLazySingleton<AuthStorage>(() => AuthStorage(sl<AppCache<String>>()))
    ..registerLazySingleton<LocalService>(() => LocalService(sl<AppCache<String>>()))
    ..registerLazySingleton<ThemeService>(() => ThemeService(sl<AppCache<String>>()))
    ..registerLazySingleton<ReadThemeService>(() => ReadThemeService(sl<AppCache<int>>()))
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<RemoteClient>(() => RemoteClient(Dio()))
    ..registerLazySingleton<LocalClient<String>>(() => LocalClient(boxData))
    ..registerFactory<FetchPageRepo>(() => FetchPageRepo(sl<RemoteClient>(), sl<LocalClient<String>>()));
}

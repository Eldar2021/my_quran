import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/modules/modules.dart';

final sl = GetIt.I;

void setup(Box<String> boxData, Box<String> boxApp) {
  sl
    ..registerLazySingleton<AppCache<String>>(() => AppCache(boxApp))
    ..registerLazySingleton<AuthStorage>(() => AuthStorage(sl<AppCache<String>>()))
    ..registerLazySingleton<LocalService>(() => LocalService(sl<AppCache<String>>()))
    ..registerLazySingleton<ThemeService>(() => ThemeService(sl<AppCache<String>>()))
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<RemoteClient>(() => RemoteClient(Dio()))
    ..registerLazySingleton<LocalClient<String>>(() => LocalClient(boxData))
    ..registerFactory<FetchPageRepo>(() => FetchPageRepo(sl<RemoteClient>(), sl<LocalClient<String>>()));
}

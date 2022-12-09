import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hatim/modules/modules.dart';
import 'package:hive/hive.dart';

import 'package:hatim/core/core.dart';

final sl = GetIt.I;

void setup(
  Box<String> box,
) {
  sl
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<RemoteClient>(() => RemoteClient(Dio()))
    ..registerLazySingleton<LocalClient<String>>(() => LocalClient(box))
    ..registerFactory(() => FetchPageRepo(sl<RemoteClient>(), sl<LocalClient<String>>()));
}

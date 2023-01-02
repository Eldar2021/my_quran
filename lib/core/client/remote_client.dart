import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:hatim/core/core.dart';

class RemoteClient {
  const RemoteClient(this.dio);

  final Dio dio;

  Future<Either<ServerExc, T>> getData<T>(
    String path, {
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(path);
    if (response.statusCode == 200) {
      try {
        final model = fromJson(response.data!);
        return Right(model);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else if (response.statusCode == 401) {
      return const Left(ServerExc('token error'));
    } else {
      return const Left(ServerExc('unknown error'));
    }
  }
}

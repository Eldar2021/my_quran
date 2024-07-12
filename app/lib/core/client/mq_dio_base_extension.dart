part of 'mq_dio.dart';

extension MqDioBaseMehtods on MqDio {
  Future<Either<T, CustomException>> _get<T>(String url) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.get<T>(url);
        return Right(response.data as T);
      } else {
        return const Left(CustomException(FailureType.connection));
      }
    } on DioException catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_parseDioException(e));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_unknownExc(e, s));
    }
  }

  Future<Either<T, CustomException>> _post<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.post<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(CustomException(FailureType.connection));
      }
    } on DioException catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_parseDioException(e));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_unknownExc(e, s));
    }
  }

  Future<Either<T, CustomException>> _put<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.put<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(CustomException(FailureType.connection));
      }
    } on DioException catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_parseDioException(e));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_unknownExc(e, s));
    }
  }

  Future<Either<T, CustomException>> _patch<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.patch<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(CustomException(FailureType.connection));
      }
    } on DioException catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_parseDioException(e));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(_unknownExc(e, s));
    }
  }

  Future<Either<T, CustomException>> _convertType<T>({
    required Either<Map<String, dynamic>, CustomException> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return jsonData.fold(
        Left.new,
        (e) => Right(fromJson(e)),
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(CustomException(FailureType.deserialization, message: '$e'));
    }
  }

  Future<Either<List<T>, CustomException>> _convertListOfType<T>({
    required Either<List<dynamic>, CustomException> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return jsonData.fold(
        Left.new,
        (r) => Right(r.map((e) => fromJson(e as Map<String, dynamic>)).toList()),
      );
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      return Left(CustomException(FailureType.deserialization, message: '$e'));
    }
  }

  CustomException _unknownExc(Object e, StackTrace? s) {
    return CustomException(FailureType.unknown, error: e, stackTrace: s);
  }

  CustomException _parseDioException(DioException exception) {
    return switch (exception.response?.statusCode) {
      400 => CustomException(
          FailureType.badRequest,
          statusCode: 400,
          message: exception.message,
          error: exception.error,
        ),
      401 => CustomException(
          FailureType.noAuthorization,
          message: exception.message,
          statusCode: 401,
          error: exception.error,
        ),
      403 => CustomException(
          FailureType.forbidden,
          message: exception.message,
          statusCode: 403,
          error: exception.error,
        ),
      500 => CustomException(
          FailureType.internalServer,
          message: exception.message,
          statusCode: 500,
          error: exception.error,
        ),
      _ => CustomException(
          FailureType.unknown,
          message: exception.message,
          statusCode: exception.response?.statusCode,
          error: exception.error,
        ),
    };
  }
}

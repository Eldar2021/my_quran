part of 'mq_remote_client.dart';

/// Extension on [MqRemoteClient] providing base methods for HTTP operations.
extension MqRemoteClientBaseMehtods on MqRemoteClient {
  /// Performs an HTTP GET request to the specified [url].
  /// Returns either the response data [T] or an [MqRemoteException].
  Future<Either<T, MqRemoteException>> _get<T>(String url) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.get<T>(url);
        return Right(response.data as T);
      } else {
        return const Left(MqRemoteException(FailureType.connection));
      }
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  /// Performs an HTTP POST request to the specified [url] with an optional [body].
  /// Returns either the response data [T] or an [MqRemoteException].
  Future<Either<T, MqRemoteException>> _post<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.post<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(MqRemoteException(FailureType.connection));
      }
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  /// Performs an HTTP PUT request to the specified [url] with an optional [body].
  /// Returns either the response data [T] or an [MqRemoteException].
  Future<Either<T, MqRemoteException>> _put<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.put<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(MqRemoteException(FailureType.connection));
      }
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  /// Performs an HTTP PATCH request to the specified [url] with an optional [body].
  /// Returns either the response data [T] or an [MqRemoteException].
  Future<Either<T, MqRemoteException>> _patch<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.patch<T>(url, data: body);
        return Right(response.data as T);
      } else {
        return const Left(MqRemoteException(FailureType.connection));
      }
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  /// Converts JSON data to a specific type [T] using [fromJson] function.
  /// Returns either the converted type [T] or an [MqRemoteException].
  Future<Either<T, MqRemoteException>> _convertType<T>({
    required Either<Map<String, dynamic>, MqRemoteException> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return jsonData.fold(
        Left.new,
        (e) => Right(fromJson(e)),
      );
    } catch (e) {
      return Left(MqRemoteException(FailureType.deserialization, message: '$e'));
    }
  }

  /// Converts a list of JSON data to a list of type [T] using [fromJson] function.
  /// Returns either the list of type [T] or an [MqRemoteException].
  Future<Either<List<T>, MqRemoteException>> _convertListOfType<T>({
    required Either<List<dynamic>, MqRemoteException> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return jsonData.fold(
        Left.new,
        (r) => Right(r.map((e) => fromJson(e as Map<String, dynamic>)).toList()),
      );
    } catch (e) {
      return Left(MqRemoteException(FailureType.deserialization, message: '$e'));
    }
  }

  /// Creates an [MqRemoteException] for an unknown error.
  MqRemoteException _unknownExc(Object e, StackTrace? s) {
    return MqRemoteException(FailureType.unknown, error: e, stackTrace: s);
  }

  /// Parses a [DioException] and returns an appropriate [MqRemoteException].
  MqRemoteException _parseDioException(DioException exception) {
    return switch (exception.response?.statusCode) {
      400 => MqRemoteException(
          FailureType.badRequest,
          statusCode: 400,
          message: exception.message,
          error: exception.error,
        ),
      401 => MqRemoteException(
          FailureType.noAuthorization,
          message: exception.message,
          statusCode: 401,
          error: exception.error,
        ),
      403 => MqRemoteException(
          FailureType.forbidden,
          message: exception.message,
          statusCode: 403,
          error: exception.error,
        ),
      500 => MqRemoteException(
          FailureType.internalServer,
          message: exception.message,
          statusCode: 500,
          error: exception.error,
        ),
      _ => MqRemoteException(
          FailureType.unknown,
          message: exception.message,
          statusCode: exception.response?.statusCode,
          error: exception.error,
        ),
    };
  }
}

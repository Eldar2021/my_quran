part of 'mq_remote_client.dart';

/// Extension on [MqRemoteClient] providing base methods for HTTP operations.
extension MqRemoteClientBaseMehtods on MqRemoteClient {
  /// Performs an HTTP GET request to the specified [url].
  Future<T> _get<T>(String url) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.get<T>(url);
        return response.data as T;
      } else {
        throw const NerWorkException();
      }
    } catch (e, s) {
      log('MqRemoteClientBaseMehtods._get', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Performs an HTTP POST request to the specified [url] with an optional [body].
  Future<T> _post<T>(String url, {Map<String, dynamic>? body}) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.post<T>(url, data: body);
        return response.data as T;
      } else {
        throw const NerWorkException();
      }
    } catch (e, s) {
      log('MqRemoteClientBaseMehtods._post', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Performs an HTTP PUT request to the specified [url] with an optional [body].
  Future<T> _put<T>(String url, {Map<String, dynamic>? body}) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.put<T>(url, data: body);
        return response.data as T;
      } else {
        throw const NerWorkException();
      }
    } catch (e, s) {
      log('MqRemoteClientBaseMehtods._put', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Performs an HTTP PATCH request to the specified [url] with an optional [body].
  Future<T> _patch<T>(String url, {Map<String, dynamic>? body}) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.patch<T>(url, data: body);
        return response.data as T;
      } else {
        throw const NerWorkException();
      }
    } catch (e, s) {
      log('MqRemoteClientBaseMehtods._patch', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Performs an HTTP DELETE request to the specified [url] with an optional [body].
  Future<T> _delete<T>(String url, {Map<String, dynamic>? body}) async {
    try {
      if (await network.checkInternetConnection()) {
        final response = await dio.delete<T>(url, data: body);
        return response.data as T;
      } else {
        throw const NerWorkException();
      }
    } catch (e, s) {
      log('MqRemoteClientBaseMehtods._delete', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Converts JSON data to a specific type [T] using [fromJson] function.
  Future<T> _convertType<T>({
    required Map<String, dynamic> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return fromJson(jsonData);
    } catch (e) {
      throw ConvertException('$e');
    }
  }

  /// Converts a list of JSON data to a list of type [T] using [fromJson] function.
  Future<List<T>> _convertListOfType<T>({
    required List<dynamic> jsonData,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      return jsonData.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ConvertException('$e');
    }
  }
}

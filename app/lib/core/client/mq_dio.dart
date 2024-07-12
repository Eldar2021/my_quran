import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_quran/core/core.dart';

part 'mq_dio_base_extension.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);
typedef ResolveValue = String? Function();

@immutable
class MqDio {
  const MqDio({
    required this.dio,
    required this.network,
    this.language,
    this.token,
    this.oldToken,
  });

  final Dio dio;
  final NetworkClient network;
  final ResolveValue? language;
  final ResolveValue? token;
  final ResolveValue? oldToken;

  void initilize() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final tokenValue = token?.call();
          final languageValue = language?.call();
          final oldTokenValue = oldToken?.call();
          options.headers = {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
            'X-CSRFTOKEN': '9KDITf4aeXMyyQffH5TMtuuUtSfOSLtnZIeF2JZBXJziDfbP0wLo7xrWsUVeL2wO',
            if (tokenValue != null) 'Authorization': 'Token $tokenValue',
            if (languageValue != null) 'Accept-Language': languageValue,
            if (oldTokenValue != null) 'old-token': 'Old Token $oldTokenValue',
          };
          return handler.next(options);
        },
      ),
    );
  }

  Future<Either<T, CustomException>> get<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final response = await _get<T>(url);
    return response;
  }

  Future<Either<T, CustomException>> getType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<Map<String, dynamic>>(url);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  Future<Either<List<T>, CustomException>> getListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<List<dynamic>>(url);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  Future<Either<T, CustomException>> post<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _post<T>(url, body: body);
    return response;
  }

  Future<Either<T, CustomException>> postType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  Future<Either<List<T>, CustomException>> postListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  Future<Either<T, CustomException>> put<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _put<T>(url, body: body);
    return response;
  }

  Future<Either<T, CustomException>> putType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  Future<Either<List<T>, CustomException>> putListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  Future<Either<T, CustomException>> patch<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _patch<T>(url, body: body);
    return response;
  }

  Future<Either<T, CustomException>> patchType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  Future<Either<List<T>, CustomException>> patchListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }
}

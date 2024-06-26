import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:my_quran/core/core.dart';

@immutable
class RemoteClient {
  const RemoteClient(Client client, this.networkClient) : _client = client;

  final Client _client;
  final NetworkClient networkClient;

  /// Get a token and return header
  Map<String, String> getHeader(String? token) {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'X-CSRFTOKEN': '9KDITf4aeXMyyQffH5TMtuuUtSfOSLtnZIeF2JZBXJziDfbP0wLo7xrWsUVeL2wO',
    };
    if (token != null) headers['Authorization'] = 'Token $token';

    return headers;
  }

  /// Working with the response
  Future<Either<T, Exception>> responseType<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    /// if the response is successful, return the data  fromJson
    if (response.statusCode == 200) {
      try {
        final model = fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        return Right(model);
      } catch (e, s) {
        MqCrashlytics.report(e, s);
        return Left(ConvertExc(message: '$e'));
      }

      /// if an Unauthorized  return Authentication Exception
    } else if (response.statusCode == 401) {
      return const Left(AuthenticationExc());
    } else {
      /// if the response is not successful and unauthorized, it will return a server exception
      return const Left(ServerExc('server exception'));
    }
  }

  /// Get Json data
  Future<Either<T, Exception>> get<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
  }) async {
    try {
      final header = getHeader(token);
      if (await networkClient.checkInternetConnection()) {
        final response = await _client.get(
          Uri.parse(path),
          headers: header,
        );
        return responseType<T>(response, fromJson);
      } else {
        return const Left(NetworkExc());
      }
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log(e.toString());
      return const Left(ServerExc(null));
    }
  }

  /// Perform a query using the "POST" method and using the JSON content type
  Future<Either<T, Exception>> post<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final header = getHeader(token);
      if (await networkClient.checkInternetConnection()) {
        final response = await _client.post(
          Uri.parse(path),
          headers: header,
          body: jsonEncode(body),
        );
        return responseType<T>(response, fromJson);
      } else {
        return const Left(NetworkExc());
      }
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log(e.toString());
      return const Left(ServerExc(null));
    }
  }

  /// Perform a query using the "PATCH" method and using the JSON content type
  Future<Either<T, Exception>> patch<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final header = getHeader(token);
    if (await networkClient.checkInternetConnection()) {
      final response = await _client.patch(
        Uri.parse(path),
        body: jsonEncode(body),
        headers: header,
      );
      return responseType<T>(response, fromJson);
    } else {
      return const Left(NetworkExc());
    }
  }

  /// Perform a query using the "PUT" method and using the JSON content type
  Future<Either<T, Exception>> put<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final header = getHeader(token);
    if (await networkClient.checkInternetConnection()) {
      final response = await _client.put(
        Uri.parse(path),
        body: jsonEncode(body),
        headers: header,
      );
      return responseType<T>(response, fromJson);
    } else {
      return const Left(NetworkExc());
    }
  }
}

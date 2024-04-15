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
  static final Map<String, dynamic> _cache = {};

  /// Get a token and return header
  Map<String, String> getHeader(String? token) {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';

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
      } catch (e) {
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

  Future<Either<T, Exception>> fetchData<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    required Future<Response> Function() requestMethod,
    String? token,
    bool cache = true,
  }) async {
    try {
      if (await networkClient.checkInternetConnection()) {
        final response = await requestMethod();

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          if (cache) {
            _cache[path] = data; // Cache fetched data
          }
          return responseType<T>(response, fromJson);
        } else {
          return const Left(ServerExc('Failed to fetch data'));
        }
      } else {
        if (_cache.containsKey(path)) {
          // If offline and data available in cache, return cached data
          final data = _cache[path] as Map<String, dynamic>;
          final model = fromJson(data);
          return Right(model);
        } else {
          return const Left(NetworkExc());
        }
      }
    } catch (e) {
      log(e.toString());
      return const Left(ServerExc(null));
    }
  }

  /// Get Json data

  Future<Either<T, Exception>> get<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    bool cache = true,
  }) async {
    return fetchData<T>(
      path,
      fromJson: fromJson,
      token: token,
      cache: cache,
      requestMethod: () => _client.get(
        Uri.parse(path),
        headers: getHeader(token),
      ),
    );
  }

  /// Perform a query using the "POST" method and using the JSON content type
  Future<Either<T, Exception>> post<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
    bool cache = true,
  }) async {
    return fetchData<T>(
      path,
      fromJson: fromJson,
      token: token,
      cache: cache,
      requestMethod: () => _client.post(
        Uri.parse(path),
        headers: getHeader(token),
        body: jsonEncode(body),
      ),
    );
  }

  /// Perform a query using the "PATCH" method and using the JSON content type
  Future<Either<T, Exception>> patch<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
    bool cache = true,
  }) async {
    return fetchData<T>(
      path,
      fromJson: fromJson,
      token: token,
      cache: cache,
      requestMethod: () => _client.patch(
        Uri.parse(path),
        headers: getHeader(token),
        body: jsonEncode(body),
      ),
    );
  }

  /// Perform a query using the "PUT" method and using the JSON content type
  Future<Either<T, Exception>> put<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
    Map<String, dynamic>? body,
    bool cache = true,
  }) async {
    return fetchData<T>(
      path,
      fromJson: fromJson,
      token: token,
      cache: cache,
      requestMethod: () => _client.put(
        Uri.parse(path),
        headers: getHeader(token),
        body: jsonEncode(body),
      ),
    );
  }
}

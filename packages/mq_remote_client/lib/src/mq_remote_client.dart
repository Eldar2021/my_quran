import 'package:dio/dio.dart';
import 'package:mq_either/mq_either.dart';
import 'package:mq_remote_client/src/http_exception.dart';
import 'package:mq_remote_client/src/network_client.dart';

part 'mq_remote_client_base_extension.dart';

/// {@template mq_remote_client}
/// MQ remote client package
/// {@endtemplate}

typedef FromJson<T> = T Function(Map<String, dynamic>);

/// A function type that converts a [Map<String, dynamic>] to an object of type T
///
/// Used to deserialize JSON responses from the server.
typedef ResolveValue = String? Function();

/// A client for making HTTP requests with custom headers and handling JSON
/// responses.
class MqRemoteClient {
  /// {@macro mq_remote_client}
  const MqRemoteClient({
    required this.dio,
    required this.network,
    this.language,
    this.token,
    this.oldToken,
  });

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  /// The network client for handling network-related tasks.
  final NetworkClient network;

  /// A function that resolves the language value for the headers.
  final ResolveValue? language;

  /// A function that resolves the authorization token for the headers.
  final ResolveValue? token;

  /// A function that resolves the old token for the headers.
  final ResolveValue? oldToken;

  /// Initializes the Dio instance with interceptors to add custom headers.
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

  /// Makes a GET request to the given [url] and parses the response as type [T]
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> get<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final response = await _get<T>(url);
    return response;
  }

  /// Makes a GET request to the given [url] and parses the response as type [T]
  /// from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> getType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<Map<String, dynamic>>(url);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a GET request to the given [url] and parses the response as a list
  /// of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, CustomException>> getListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<List<dynamic>>(url);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> post<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _post<T>(url, body: body);
    return response;
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> postType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, CustomException>> postListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> put<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _put<T>(url, body: body);
    return response;
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> putType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, CustomException>> putListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as type [T].
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> patch<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _patch<T>(url, body: body);
    return response;
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, CustomException>> patchType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, CustomException>> patchListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  // Private methods _get, _post, _put, _patch, _convertType, _convertListOfType
}

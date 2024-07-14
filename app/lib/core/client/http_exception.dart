import 'package:meta/meta.dart';

@immutable
final class CustomException implements Exception {
  const CustomException(
    this.failureType, {
    this.error,
    this.message,
    this.stackTrace,
    this.statusCode,
  });

  final dynamic error;
  final FailureType failureType;
  final StackTrace? stackTrace;
  final String? message;
  final int? statusCode;
}

enum FailureType {
  /// Represents http error 400
  badRequest('Represents http error '),

  /// Represents http error 401
  noAuthorization('Authentication error'),

  /// Forbidden http error 403
  forbidden('Forbidden http error'),

  /// Internal server http error 500
  internalServer('Internal server http error'),

  /// Json decode error
  decode('Json decode error'),

  /// Json deserialization error
  deserialization('Json deserialization error'),

  /// Internet Connection error
  connection('Device unconected internet'),

  /// Unknown error
  unknown('Unknown error');

  const FailureType(this.message);

  final String message;
}

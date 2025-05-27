import 'package:meta/meta.dart';

/// Exception thrown when there is a network error during operations.
@immutable
final class NerWorkException implements Exception {
  const NerWorkException();
}

/// Exception thrown when there is an error converting data.
final class ConvertException implements Exception {
  const ConvertException(this.message);

  final String message;
}

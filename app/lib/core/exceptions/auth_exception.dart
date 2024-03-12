import 'package:meta/meta.dart';

@immutable
final class AuthenticationExc implements Exception {
  const AuthenticationExc({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Auhtentication Exception';
}

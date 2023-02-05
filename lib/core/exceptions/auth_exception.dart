/// Auhtentication Exception
class AuthenticationException implements Exception {
  const AuthenticationException({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Auhtentication Exception';
}

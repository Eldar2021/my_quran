import 'package:meta/meta.dart';

@immutable
final class LoginParam {
  const LoginParam({
    required this.name,
    required this.accessToken,
    this.identityToken,
  });

  final String name;
  final String accessToken;
  final String? identityToken;
}

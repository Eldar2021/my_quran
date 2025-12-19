import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class StorageKeys {
  const StorageKeys._();

  static const localeKey = 'locale';
  static const genderKey = 'gender';
  static const String tokenKey = AuthLocalDataSource.tokenKey;
}

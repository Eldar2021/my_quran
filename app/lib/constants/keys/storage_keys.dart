import 'package:meta/meta.dart';
import 'package:my_quran/config/config.dart';

@immutable
final class StorageKeys {
  const StorageKeys._();

  static String get localeKey => apiConst.isDevmode ? _localeKeyDev : _localeKey;
  static String get tokenKey => apiConst.isDevmode ? _tokenKeyDev : _tokenKey;
  static String get oldTokenKey => apiConst.isDevmode ? _oldTokenKeyDev : _oldTokenKey;

  static const _localeKey = 'locale';
  static const _tokenKey = 'token-new';
  static const _oldTokenKey = 'token';

  static const _localeKeyDev = 'locale-dev';
  static const _tokenKeyDev = 'token-dev-new';
  static const _oldTokenKeyDev = 'token-dev';
}

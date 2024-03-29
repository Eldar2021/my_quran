import 'package:mq_storage/src/interface/storage_exception.dart';
import 'package:mq_storage/src/interface/storage_sync_read_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A PreferencesStorage client which implements the base [StorageInterfaceSyncRead].
/// [PreferencesStorage] uses `SharedPreferences` internally.
///
/// ```dart
/// // Create a `PreferencesStorage` instance.
/// final storage = await PreferencesStorage.getInstance();
///
/// // Write a key/value pair.
/// await storage.setString(key: 'my_key', value: 'my_value');
///
/// // Read value for key.
/// final value = storage.getString(key: 'my_key'); // 'my_value'
/// ```
class PreferencesStorage implements StorageInterfaceSyncRead {
  const PreferencesStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Returns a new instance of [PreferencesStorage].
  ///
  /// If [SharedPreferences] is not provided, the default instance will be used.
  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async {
    return PreferencesStorage._(pref ?? await SharedPreferences.getInstance());
  }

  @override
  String? readString({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  bool? readBool({required String key}) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  double? readDouble({required String key}) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  int? readInt({required String key}) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  List<String>? readStringList({required String key}) {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeString({required String key, required String value}) {
    try {
      return _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeBool({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeDouble({required String key, required double value}) {
    try {
      return _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeInt({required String key, required int value}) {
    try {
      return _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeStringList({required String key, required List<String> value}) {
    try {
      return _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> delete({required String key}) async {
    try {
      return _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> clear() {
    try {
      return _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}

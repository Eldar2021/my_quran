import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.appLocalDataSource);

  final AppLocalDataSource appLocalDataSource;

  @override
  Locale get getLocale {
    return appLocalDataSource.init;
  }

  @override
  Future<void> setLocale(String langKey) async {
    await appLocalDataSource.setLocale(langKey);
  }

  @override
  String get appVersion => appLocalDataSource.appVersion;
}

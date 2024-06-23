import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.appLocalDataSource);

  final AppLocalDataSource appLocalDataSource;

  @override
  String get appVersion => appLocalDataSource.appVersion;
}

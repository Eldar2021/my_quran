import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  String get appVersion => '1.3.1';
}

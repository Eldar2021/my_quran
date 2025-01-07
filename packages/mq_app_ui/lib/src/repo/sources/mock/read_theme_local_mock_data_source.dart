import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class LocalThemeDataSourceMock implements LocalThemeDataSource {
  const LocalThemeDataSourceMock();

  @override
  ReadThemeData getInitialThemeState() {
    return ReadThemeData.initial;
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return Future.value();
  }
}

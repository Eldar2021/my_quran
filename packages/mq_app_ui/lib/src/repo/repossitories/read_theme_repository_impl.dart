import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class ReadThemeRepositoryImpl implements ReadThemeRepository {
  const ReadThemeRepositoryImpl(this.localThemeDataSource);

  final LocalThemeDataSource localThemeDataSource;

  @override
  ReadThemeData getInitialThemeState() {
    return localThemeDataSource.getInitialThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return localThemeDataSource.saveThemeState(themeState);
  }
}

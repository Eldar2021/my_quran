import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
final class AppLocalDataSourceImpl implements AppLocalDataSource {
  const AppLocalDataSourceImpl({
    required this.packageInfo,
  });

  final PackageInfo packageInfo;

  @override
  String get appVersion => packageInfo.version;
}

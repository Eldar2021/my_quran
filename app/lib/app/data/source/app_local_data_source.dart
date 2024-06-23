import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
final class AppLocalDataSource {
  const AppLocalDataSource({
    required this.packageInfo,
  });

  final PackageInfo packageInfo;

  String get appVersion => packageInfo.version;
}

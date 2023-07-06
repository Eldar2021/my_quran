import 'package:flutter/foundation.dart';

@immutable
final class AppConfig {
  const AppConfig({this.isIntegrationTest = false});

  final bool isIntegrationTest;
}

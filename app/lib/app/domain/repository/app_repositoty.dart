import 'package:flutter/material.dart';

abstract class AppRepository {
  Locale get getLocale;
  String get appVersion;
  Future<void> setLocale(String langKey);
}

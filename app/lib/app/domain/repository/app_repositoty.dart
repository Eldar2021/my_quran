import 'package:flutter/material.dart';

abstract class AppRepository {
  Locale get getLocale;
  Future<void> setLocale(String langKey);
}

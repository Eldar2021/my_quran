import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class SetLocaleUseCase {
  const SetLocaleUseCase(this.appRepository);

  final AppRepository appRepository;

  Future<Locale?> call(String langKey) async {
    await appRepository.setLocale(langKey);
    return Locale(langKey);
  }
}

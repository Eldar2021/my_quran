import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class GetCurrentLocaleUseCase {
  const GetCurrentLocaleUseCase(this.appRepository);

  final AppRepository appRepository;

  Locale get getCurrentLocale {
    return appRepository.getLocale;
  }
}

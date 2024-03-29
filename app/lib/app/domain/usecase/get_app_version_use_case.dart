import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class GetAppVersionUseCase {
  const GetAppVersionUseCase(this.appRepository);

  final AppRepository appRepository;

  String get call {
    return appRepository.appVersion;
  }
}

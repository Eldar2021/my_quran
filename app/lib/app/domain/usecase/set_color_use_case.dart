import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class SetColorUseCase {
  const SetColorUseCase(this.themeRepository);

  final ThemeRepository themeRepository;

  Future<void> setColor(int index, Color color) async {
    await themeRepository.setColor(index);
  }
}

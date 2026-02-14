import 'dart:io';

import 'package:meta/meta.dart';

@immutable
final class QuranFontModel {
  const QuranFontModel({
    required this.normalFont,
    required this.tajweedFont,
  });

  final File normalFont;
  final File tajweedFont;
}

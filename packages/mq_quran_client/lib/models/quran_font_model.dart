import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuranFontModel extends Equatable {
  const QuranFontModel({
    required this.normalFont,
    required this.tajweedFont,
  });

  final File normalFont;
  final File tajweedFont;

  @override
  List<Object?> get props => [
    normalFont,
    tajweedFont,
  ];
}

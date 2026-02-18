import 'package:flutter/cupertino.dart';

extension QuranFontSize on BuildContext {
  double get defaultFontSize {
    final screenWidth = MediaQuery.of(this).size.width;

    if (screenWidth < 480) {
      final calculated = (screenWidth / 430) * 28;
      return calculated < 24 ? 24 : calculated;
    }
    if (screenWidth < 900) return 32;
    return 36;
  }
}

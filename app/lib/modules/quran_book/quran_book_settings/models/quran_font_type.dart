enum QuranFontType {
  complex,
  tajweed,
  uthmanic
  ;

  factory QuranFontType.fromIndex(int index) {
    return switch (index) {
      0 => QuranFontType.complex,
      1 => QuranFontType.tajweed,
      2 => QuranFontType.uthmanic,
      _ => QuranFontType.complex,
    };
  }

  int get indexValue {
    return switch (this) {
      QuranFontType.complex => 0,
      QuranFontType.tajweed => 1,
      QuranFontType.uthmanic => 2,
    };
  }
}

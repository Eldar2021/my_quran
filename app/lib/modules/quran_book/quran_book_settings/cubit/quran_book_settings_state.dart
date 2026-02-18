part of 'quran_book_settings_cubit.dart';

enum QuranFontType {
  complex,
  tajweed,
  uthmanic;

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

const _frReadThemeColor = [
  Color(0xff000000),
  Color(0xff000000),
];

const bgReadThemeColor = [
  Color(0xffFFFFFF),
  Color(0xffFFEED6),
];

const _loadingThemeColor = [
  Color.fromARGB(255, 213, 210, 210),
  Color.fromARGB(255, 241, 216, 180),
];

final class QuranBookSettingsState extends Equatable {
  const QuranBookSettingsState({
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 16,
    this.modeIndex = 1,
    this.textSize = 28,
    this.fontType = QuranFontType.complex,
  });

  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final int modeIndex;
  final double textSize;
  final QuranFontType fontType;

  @override
  List<Object> get props => [
    verticalSpaceSize,
    horizontalSpaceSize,
    modeIndex,
    textSize,
    fontType,
  ];

  QuranBookSettingsState copyWith({
    double? verticalSpaceSize,
    double? horizontalSpaceSize,
    int? modeIndex,
    double? textSize,
    QuranFontType? fontType,
  }) {
    return QuranBookSettingsState(
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
      fontType: fontType ?? this.fontType,
    );
  }

  Color get frColor {
    try {
      return _frReadThemeColor[modeIndex];
    } on Object catch (_) {
      return _frReadThemeColor[1];
    }
  }

  Color get bgColor {
    try {
      return bgReadThemeColor[modeIndex];
    } on Object catch (_) {
      return bgReadThemeColor[1];
    }
  }

  Color get loadingColor {
    try {
      return _loadingThemeColor[modeIndex];
    } on Object catch (_) {
      return _loadingThemeColor[1];
    }
  }
}

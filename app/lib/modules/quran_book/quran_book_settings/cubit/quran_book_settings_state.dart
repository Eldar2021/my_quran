part of 'quran_book_settings_cubit.dart';

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
      return ReadThemeData.frReadThemeColor[modeIndex];
    } on Object catch (_) {
      return ReadThemeData.frReadThemeColor[1];
    }
  }

  Color get bgColor {
    try {
      return ReadThemeData.bgReadThemeColor[modeIndex];
    } on Object catch (_) {
      return ReadThemeData.bgReadThemeColor[1];
    }
  }

  Color get loadingColor {
    try {
      return ReadThemeData.loadingThemeColor[modeIndex];
    } on Object catch (_) {
      return ReadThemeData.loadingThemeColor[1];
    }
  }
}

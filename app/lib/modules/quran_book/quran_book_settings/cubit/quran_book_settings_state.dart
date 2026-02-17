part of 'quran_book_settings_cubit.dart';

const _frReadThemeColor = [
  Color(0xff000000),
  Color(0xff000000),
];

const _bgReadThemeColor = [
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
  });

  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final int modeIndex;
  final double textSize;

  @override
  List<Object> get props => [
    verticalSpaceSize,
    horizontalSpaceSize,
    modeIndex,
    textSize,
  ];

  QuranBookSettingsState copyWith({
    double? verticalSpaceSize,
    double? horizontalSpaceSize,
    int? modeIndex,
    double? textSize,
  }) {
    return QuranBookSettingsState(
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
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
      return _bgReadThemeColor[modeIndex];
    } on Object catch (_) {
      return _bgReadThemeColor[1];
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

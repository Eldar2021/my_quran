part of 'quran_book_settings_cubit.dart';

const _frReadThemeColor = [
  Color(0xff000000),
  Color(0xff000000),
  Color(0xffFFFFFF),
  Color(0xffFFFFFF),
];

const _bgReadThemeColor = [
  Color(0xffFFFFFF),
  Color(0xffFFEED6),
  Color(0xff1C1C1E),
  Color(0xff0E0E0F),
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

  Color get frColor => _frReadThemeColor[modeIndex];

  Color get bgColor => _bgReadThemeColor[modeIndex];
}

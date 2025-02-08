part of 'quran_book_theme_cubit.dart';

@immutable
final class QuranBookThemeState extends Equatable {
  const QuranBookThemeState({
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 14,
    this.modeIndex = 1,
    this.textSize = 28,
  });

  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final int modeIndex;
  final double textSize;

  @override
  List<Object?> get props => [
        verticalSpaceSize,
        horizontalSpaceSize,
        modeIndex,
        textSize,
      ];

  QuranBookThemeState copyWith({
    double? verticalSpaceSize,
    double? horizontalSpaceSize,
    int? modeIndex,
    double? textSize,
  }) {
    return QuranBookThemeState(
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }

  Color get frColor {
    return ReadThemeData.frReadThemeColor[modeIndex];
  }

  Color get bgColor {
    return ReadThemeData.bgReadThemeColor[modeIndex];
  }
}

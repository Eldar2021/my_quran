part of 'read_theme_cubit.dart';

class ReadThemeState extends Equatable {
  const ReadThemeState(this.theme);

  final ReadTheme theme;

  @override
  List<Object> get props => [theme];
}

class ReadTheme extends Equatable {
  const ReadTheme({
    this.verticalSpace = 0,
    this.horizontalSpace = 14,
    this.modeIndex = 2,
    this.textSize = 18,
  });

  final int verticalSpace;
  final int horizontalSpace;
  final int modeIndex;
  final int textSize;

  @override
  List<Object?> get props => [
        verticalSpace,
        horizontalSpace,
        modeIndex,
        textSize,
      ];

  ReadTheme copyWith({
    int? verticalSpace,
    int? horizontalSpace,
    int? modeIndex,
    int? textSize,
  }) {
    return ReadTheme(
      verticalSpace: verticalSpace ?? this.verticalSpace,
      horizontalSpace: horizontalSpace ?? this.horizontalSpace,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}

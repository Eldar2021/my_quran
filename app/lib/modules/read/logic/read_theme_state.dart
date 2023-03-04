part of 'read_theme_cubit.dart';

class ReadThemeState extends Equatable {
  const ReadThemeState(this.theme);

  final ReadTheme theme;

  @override
  List<Object> get props => [theme];
}

class ReadTheme extends Equatable {
  const ReadTheme({
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 14,
    this.modeIndex = 2,
    this.textSize = 22,
  });

  final int verticalSpaceSize;
  final int horizontalSpaceSize;
  final int modeIndex;
  final int textSize;

  @override
  List<Object?> get props => [
        verticalSpaceSize,
        horizontalSpaceSize,
        modeIndex,
        textSize,
      ];

  ReadTheme copyWith({
    int? verticalSpaceSize,
    int? horizontalSpaceSize,
    int? modeIndex,
    int? textSize,
  }) {
    return ReadTheme(
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}

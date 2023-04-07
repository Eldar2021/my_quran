part of 'read_theme_cubit.dart';

class ReadThemeState extends Equatable {
  const ReadThemeState(this.theme);

  final ReadTheme theme;

  @override
  List<Object> get props => [theme];
}

class ReadTheme extends Equatable {
  const ReadTheme({
    required this.fontFamily,
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 14,
    this.modeIndex = 2,
    this.textSize = 22,
  });

  final String fontFamily;
  final int verticalSpaceSize;
  final int horizontalSpaceSize;
  final int modeIndex;
  final int textSize;

  @override
  List<Object?> get props => [
        fontFamily,
        verticalSpaceSize,
        horizontalSpaceSize,
        modeIndex,
        textSize,
      ];

  ReadTheme copyWith({
    String? fontFamily,
    int? verticalSpaceSize,
    int? horizontalSpaceSize,
    int? modeIndex,
    int? textSize,
  }) {
    return ReadTheme(
      fontFamily: fontFamily ?? this.fontFamily,
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}

part of 'read_theme_cubit.dart';

@immutable
final class ReadThemeState extends Equatable {
  const ReadThemeState({
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

  ReadThemeState copyWith({
    double? verticalSpaceSize,
    double? horizontalSpaceSize,
    int? modeIndex,
    double? textSize,
  }) {
    return ReadThemeState(
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}

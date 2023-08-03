part of 'read_theme_cubit.dart';

class ReadThemeState extends Equatable {
  const ReadThemeState({
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 14,
    this.modeIndex = 1,
    this.textSize = 28,
  });

  factory ReadThemeState.fromJson(Map<String, dynamic> map) {
    return ReadThemeState(
      verticalSpaceSize: map['verticalSpaceSize'] as double,
      horizontalSpaceSize: map['horizontalSpaceSize'] as double,
      modeIndex: map['modeIndex'] as int,
      textSize: map['textSize'] as double,
    );
  }

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'verticalSpaceSize': verticalSpaceSize,
      'horizontalSpaceSize': horizontalSpaceSize,
      'modeIndex': modeIndex,
      'textSize': textSize,
    };
  }
}

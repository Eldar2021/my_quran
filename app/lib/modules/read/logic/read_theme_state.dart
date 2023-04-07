part of 'read_theme_cubit.dart';

class ReadThemeState extends Equatable {
  const ReadThemeState({
    this.fontFamily = 'Scheherazade New',
    this.verticalSpaceSize = 0,
    this.horizontalSpaceSize = 14,
    this.modeIndex = 2,
    this.textSize = 22,
  });

  factory ReadThemeState.fromJson(Map<String, dynamic> map) {
    return ReadThemeState(
      fontFamily: map['fontFamily'] as String,
      verticalSpaceSize: map['verticalSpaceSize'] as double,
      horizontalSpaceSize: map['horizontalSpaceSize'] as double,
      modeIndex: map['modeIndex'] as int,
      textSize: map['textSize'] as double,
    );
  }

  final String fontFamily;
  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final int modeIndex;
  final double textSize;

  @override
  List<Object?> get props => [
        fontFamily,
        verticalSpaceSize,
        horizontalSpaceSize,
        modeIndex,
        textSize,
      ];

  ReadThemeState copyWith({
    String? fontFamily,
    double? verticalSpaceSize,
    double? horizontalSpaceSize,
    int? modeIndex,
    double? textSize,
  }) {
    return ReadThemeState(
      fontFamily: fontFamily ?? this.fontFamily,
      verticalSpaceSize: verticalSpaceSize ?? this.verticalSpaceSize,
      horizontalSpaceSize: horizontalSpaceSize ?? this.horizontalSpaceSize,
      modeIndex: modeIndex ?? this.modeIndex,
      textSize: textSize ?? this.textSize,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fontFamily': fontFamily,
      'verticalSpaceSize': verticalSpaceSize,
      'horizontalSpaceSize': horizontalSpaceSize,
      'modeIndex': modeIndex,
      'textSize': textSize,
    };
  }
}

import 'package:flutter/widgets.dart';

abstract class ReadThemeRepository {
  ReadThemeData getInitialThemeState();

  Future<void> saveThemeState(ReadThemeData themeState);
}

@immutable
final class ReadThemeData {
  const ReadThemeData({
    required this.modeIndex,
    required this.verticalSpaceSize,
    required this.horizontalSpaceSize,
    required this.textSize,
  });

  factory ReadThemeData.fromJson(Map<String, dynamic> json) {
    return ReadThemeData(
      modeIndex: json['modeIndex'] as int,
      verticalSpaceSize: json['verticalSpaceSize'] as double,
      horizontalSpaceSize: json['horizontalSpaceSize'] as double,
      textSize: json['textSize'] as double,
    );
  }

  static const initial = ReadThemeData(modeIndex: 1, verticalSpaceSize: 0, horizontalSpaceSize: 14, textSize: 28);

  final int modeIndex;
  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final double textSize;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'modeIndex': modeIndex,
      'verticalSpaceSize': verticalSpaceSize,
      'horizontalSpaceSize': horizontalSpaceSize,
      'textSize': textSize,
    };
  }

  static const frReadThemeColor = [Color(0xff000000), Color(0xff000000), Color(0xffFFFFFF), Color(0xffFFFFFF)];

  Color get foregroundColor => frReadThemeColor[modeIndex];

  static const bgReadThemeColor = [Color(0xffFFFFFF), Color(0xffFFEED6), Color(0xff1C1C1E), Color(0xff0E0E0F)];

  Color get backgroundColor => bgReadThemeColor[modeIndex];
}

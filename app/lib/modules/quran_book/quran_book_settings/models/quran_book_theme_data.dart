import 'package:flutter/material.dart';

@immutable
final class ReadThemeData {
  const ReadThemeData({
    required this.modeIndex,
    required this.verticalSpaceSize,
    required this.horizontalSpaceSize,
    required this.textSize,
    required this.fontTypeIndex,
  });

  factory ReadThemeData.fromJson(Map<String, dynamic> json) {
    return ReadThemeData(
      modeIndex: json['modeIndex'] as int,
      verticalSpaceSize: json['verticalSpaceSize'] as double,
      horizontalSpaceSize: json['horizontalSpaceSize'] as double,
      textSize: json['textSize'] as double,
      fontTypeIndex: json['fontTypeIndex'] as int,
    );
  }

  final int modeIndex;
  final double verticalSpaceSize;
  final double horizontalSpaceSize;
  final double textSize;
  final int fontTypeIndex;

  static const frReadThemeColor = [
    Color(0xff000000),
    Color(0xff000000),
  ];

  static const bgReadThemeColor = [
    Color(0xffFFFFFF),
    Color(0xffFFEED6),
  ];

  static const loadingThemeColor = [
    Color.fromARGB(255, 213, 210, 210),
    Color.fromARGB(255, 241, 216, 180),
  ];

  Color get foregroundColor => frReadThemeColor[modeIndex];
  Color get backgroundColor => bgReadThemeColor[modeIndex];

  static const initial = ReadThemeData(
    modeIndex: 1,
    verticalSpaceSize: 0,
    horizontalSpaceSize: 14,
    textSize: 28,
    fontTypeIndex: 0,
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'modeIndex': modeIndex,
      'verticalSpaceSize': verticalSpaceSize,
      'horizontalSpaceSize': horizontalSpaceSize,
      'textSize': textSize,
      'fontTypeIndex': fontTypeIndex,
    };
  }
}

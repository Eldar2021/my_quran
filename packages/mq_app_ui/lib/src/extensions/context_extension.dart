import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double get widthFactor => width / 375;
  double get heightFactor => height / 812;

  double withHeight(double height) => height * heightFactor;
  double withWidth(double width) => width * widthFactor;
}

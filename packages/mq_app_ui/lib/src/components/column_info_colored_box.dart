import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class ColumnInfoColoredBox extends StatelessWidget {
  const ColumnInfoColoredBox({
    this.title = 'Title',
    this.boxColor = AppColors.tomato2,
    this.boxBorderRadius = 5,
    this.boxHeight = 15,
    this.boxWidth = 5,
    this.value = '0',
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.titleStyle,
    this.valueStyle,
    super.key,
  });

  factory ColumnInfoColoredBox.circular({
    required String title,
    required String value,
    Color boxColor = AppColors.tomato2,
    double boxRadius = 6,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
  }) {
    return ColumnInfoColoredBox(
      title: title,
      boxColor: boxColor,
      boxBorderRadius: boxRadius * 4,
      boxHeight: boxRadius * 2,
      boxWidth: boxRadius * 2,
      value: value,
      crossAxisAlignment: crossAxisAlignment,
      titleStyle: titleStyle,
      valueStyle: valueStyle,
    );
  }

  final String title;
  final Color boxColor;
  final double boxBorderRadius;
  final double boxHeight;
  final double boxWidth;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: titleStyle ?? prTextTheme.titleSmall?.copyWith(fontWeight: FontWeight.w300)),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(boxBorderRadius)),
              child: SizedBox(width: boxWidth, height: boxHeight),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: valueStyle ?? prTextTheme.titleSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

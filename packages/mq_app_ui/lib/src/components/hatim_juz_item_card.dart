import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class HatimJuzItemCard extends StatelessWidget {
  const HatimJuzItemCard({
    required this.total,
    required this.title,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    this.firstBoxColor = AppColors.tomato2,
    this.secondBoxColor = AppColors.goldenrod,
    this.thirdBoxColor = AppColors.mediumseagreen,
    this.onTap,
    super.key,
  });

  final String total;
  final String title;
  final String firstText;
  final String secondText;
  final String thirdText;
  final int firstValue;
  final int secondValue;
  final int thirdValue;
  final Color firstBoxColor;
  final Color secondBoxColor;
  final Color thirdBoxColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? colorScheme.outline.withValues(alpha: 0.3) : colorScheme.surface,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MqCircularChart(
                annotation: total,
                colors: [firstBoxColor, secondBoxColor, thirdBoxColor],
                dataSource: [firstValue, secondValue, thirdValue],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: prTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColumnInfoColoredBox(boxColor: firstBoxColor, title: firstText, value: '$firstValue'),
                        ColumnInfoColoredBox(boxColor: secondBoxColor, title: secondText, value: '$secondValue'),
                        ColumnInfoColoredBox(boxColor: thirdBoxColor, title: thirdText, value: '$thirdValue'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_quran/theme/theme.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.titleText,
    required this.valueText,
    this.verticalSpace = 15,
    this.horizontalSpace = 15,
    super.key,
  });

  final String titleText;
  final String valueText;
  final double verticalSpace;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffEDD6DE).withOpacity(0.17),
      margin: EdgeInsets.symmetric(horizontal: horizontalSpace, vertical: verticalSpace),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Text(titleText, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 30),
            Text(
              valueText,
              style: TextStyle(
                fontSize: 32,
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

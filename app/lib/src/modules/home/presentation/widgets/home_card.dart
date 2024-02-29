import 'package:flutter/material.dart';
import 'package:my_quran/src/theme/theme.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.titleText,
    required this.descriptioText,
    required this.valueText,
    this.verticalSpace = 15,
    this.horizontalSpace = 15,
    super.key,
  });

  final String titleText;
  final String descriptioText;
  final String valueText;
  final double verticalSpace;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: horizontalSpace, vertical: verticalSpace),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text(descriptioText)),
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
          ],
        ),
      ),
    );
  }
}

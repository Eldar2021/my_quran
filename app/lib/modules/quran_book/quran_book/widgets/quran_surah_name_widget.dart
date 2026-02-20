import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

class QuranSurahNameWidget extends StatelessWidget {
  const QuranSurahNameWidget({
    required this.chapterId,
    required this.color,
    required this.textSize,
    this.showDivider = true,
    super.key,
  });

  final int chapterId;
  final Color color;
  final double textSize;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDivider) const Divider(),
          Center(
            child: Text(
              chapterId.toString().padLeft(3, '0'),
              style: TextStyle(
                fontFamily: QuranFontConstants.surahNamesFont,
                package: 'mq_quran_client',
                fontSize: textSize + 16,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

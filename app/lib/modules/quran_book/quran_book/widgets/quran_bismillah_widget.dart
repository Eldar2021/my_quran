import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

class QuranBismillahWidget extends StatelessWidget {
  const QuranBismillahWidget({
    required this.color,
    required this.textSize,
    super.key,
  });

  final Color color;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: textSize + 12,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: QuranAssets.icons.bismillah.svg(
        width: double.infinity,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

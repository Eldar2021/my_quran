import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

class QuranCodeV2Content extends StatelessWidget {
  const QuranCodeV2Content({
    required this.data,
    required this.fontFamily,
    super.key,
  });

  final QuranPageModel data;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 28,
              color: Colors.black,
              height: 2,
            ),
            children: data.verses.map((verse) {
              return TextSpan(text: verse.codeV2);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

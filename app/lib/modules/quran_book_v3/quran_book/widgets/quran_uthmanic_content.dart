import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

class QuranUthmanicContent extends StatelessWidget {
  const QuranUthmanicContent({
    required this.data,
    super.key,
  });

  final QuranPageModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'UthmanicHafs',
              fontSize: 24,
              color: Colors.black,
              height: 2.2,
            ),
            children: data.verses.map((verse) {
              return TextSpan(
                text: '${verse.textUthmani} (${verse.verseNumber.toArabicDigits}) ',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

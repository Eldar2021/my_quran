import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:collection/collection.dart';

class QuranCodeV2Content extends StatelessWidget {
  const QuranCodeV2Content({
    required this.data,
    required this.fontFamily,
    required this.tajweedFontFamily,
    super.key,
  });

  final QuranPageModel data;
  final String fontFamily;
  final String tajweedFontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(
          textAlign: TextAlign.center,
          textHeightBehavior: const TextHeightBehavior(),
          text: TextSpan(
            style: _getStyle(tajweedFontFamily),
            children: data.verses.mapIndexed((index, verse) {
              return TextSpan(
                children: [
                  if (verse.isFirstAyat)
                    WidgetSpan(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            if (index != 0) const Divider(),
                            Center(
                              child: Text(
                                verse.chapterId.toString().padLeft(3, '0'),
                                style: _getStyle(QuranFontFamily.surahNames).copyWith(
                                  package: 'mq_quran_client',
                                  fontSize: 42,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (verse.showBismillah) ...[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: QuranAssets.icons.bismillah.svg(
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                  TextSpan(text: verse.formattedCode2),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  TextStyle _getStyle(String fontFamily) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      color: Colors.black,
      height: 2.2,
    );
  }
}

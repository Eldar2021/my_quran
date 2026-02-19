import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:collection/collection.dart';
import 'package:my_quran/modules/modules.dart';

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
    return QuranBookSettingBuilder.changeSpace(
      builder: (context, horizontal, vertical) {
        return Padding(
          padding: data.isSpecialIntroPage
              ? const EdgeInsets.all(16)
              : EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: _QuranV2TextWidget(
              data: data,
              fontFamily: fontFamily,
            ),
          ),
        );
      },
    );
  }
}

class _QuranV2TextWidget extends StatelessWidget {
  const _QuranV2TextWidget({
    required this.data,
    required this.fontFamily,
  });

  final QuranPageModel data;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final settings = context.select((QuranBookSettingsCubit cubit) => cubit.state);
    final fontSize = data.isSpecialIntroPage ? context.defaultFontSize : settings.textSize;
    final baseStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: settings.frColor,
      height: 2.2,
    );

    return RichText(
      textAlign: TextAlign.center,
      textHeightBehavior: const TextHeightBehavior(),
      text: TextSpan(
        style: baseStyle,
        children: data.verses.mapIndexed((index, verse) {
          return TextSpan(
            children: [
              if (verse.isFirstAyat)
                _buildSurahHeader(
                  index,
                  verse.chapterId,
                  settings.frColor,
                  fontSize,
                ),
              if (verse.showBismillah)
                _buildBismillah(
                  fontSize,
                  settings.frColor,
                ),
              TextSpan(text: verse.formattedCode2),
            ],
          );
        }).toList(),
      ),
    );
  }

  InlineSpan _buildSurahHeader(
    int index,
    int chapterId,
    Color color,
    double fontSize,
  ) {
    return WidgetSpan(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            if (index != 0) const Divider(),
            Center(
              child: Text(
                chapterId.toString().padLeft(3, '0'),
                style: TextStyle(
                  fontFamily: QuranFontConstants.surahNamesFont,
                  package: 'mq_quran_client',
                  fontSize: fontSize + 16,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildBismillah(double fontSize, Color color) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        height: fontSize + 12,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: QuranAssets.icons.bismillah.svg(
          width: double.infinity,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}

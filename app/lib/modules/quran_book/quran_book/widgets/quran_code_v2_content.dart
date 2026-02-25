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
    final settings = context.select<QuranBookSettingsCubit, QuranBookSettingsState>((cubit) => cubit.state);
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
                WidgetSpan(
                  child: QuranSurahNameWidget(
                    chapterId: verse.chapterId,
                    color: settings.frColor,
                    textSize: fontSize,
                    showDivider: index != 0,
                  ),
                ),
              if (verse.showBismillah)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: QuranBismillahWidget(
                    color: settings.frColor,
                    textSize: fontSize,
                  ),
                ),
              TextSpan(text: verse.formattedCode2),
            ],
          );
        }).toList(),
      ),
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

class QuranUthmanicContent extends StatelessWidget {
  const QuranUthmanicContent(
    this.data, {
    super.key,
    this.showErrorMessage = false,
  });

  final QuranPageModel data;
  final bool showErrorMessage;

  @override
  Widget build(BuildContext context) {
    return QuranBookSettingBuilder.changeSpace(
      builder: (context, horizontal, vertical) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
          child: Column(
            children: [
              if (showErrorMessage) const QuranBrokenBanner(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: _QuranUtnmanicTextWidget(data),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuranUtnmanicTextWidget extends StatelessWidget {
  const _QuranUtnmanicTextWidget(this.data);

  final QuranPageModel data;

  @override
  Widget build(BuildContext context) {
    final settings = context.select((QuranBookSettingsCubit cubit) => cubit.state);
    final baseStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontFamily: FontFamily.uthmanicV2,
      fontSize: settings.textSize,
      color: settings.frColor,
      height: 2.3,
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
                    textSize: settings.textSize,
                    showDivider: index != 0,
                  ),
                ),
              if (verse.showBismillah) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: QuranBismillahWidget(
                    color: settings.frColor,
                    textSize: settings.textSize,
                  ),
                ),
              ],
              TextSpan(text: verse.textUthmani),
              TextSpan(
                text: ' ${verse.ayatNumber.toArabicDigits} ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: FontFamily.uthmanicRegular,
                  fontSize: settings.textSize,
                  color: settings.frColor,
                ),
              ),
              if (verse.isFirstAyatOfQuran) const TextSpan(text: '\n'),
            ],
          );
        }).toList(),
      ),
    );
  }
}

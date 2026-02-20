import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

class QuranUthmanicContent extends StatelessWidget {
  const QuranUthmanicContent({
    required this.data,
    super.key,
  });

  final QuranPageModel data;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: themeCubit.state.horizontalSpaceSize,
        vertical: themeCubit.state.verticalSpaceSize,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: _QuranUtnmanicTextWidget(
          data: data,
          fontFamily: FontFamily.uthmanicV2,
        ),
      ),
    );
  }
}

class _QuranUtnmanicTextWidget extends StatelessWidget {
  const _QuranUtnmanicTextWidget({
    required this.data,
    required this.fontFamily,
  });

  final QuranPageModel data;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    return RichText(
      textAlign: TextAlign.center,
      textHeightBehavior: const TextHeightBehavior(),
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontFamily: FontFamily.uthmanicV2,
          fontSize: themeCubit.state.textSize,
          color: themeCubit.state.frColor,
          height: 2.3,
        ),
        children: data.verses.mapIndexed((index, verse) {
          return TextSpan(
            children: [
              if (verse.isFirstAyat)
                WidgetSpan(
                  child: QuranSurahNameWidget(
                    chapterId: verse.chapterId,
                    color: themeCubit.state.frColor,
                    textSize: themeCubit.state.textSize,
                    showDivider: index != 0,
                  ),
                ),
              if (verse.showBismillah) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: QuranBismillahWidget(
                    color: themeCubit.state.frColor,
                    textSize: themeCubit.state.textSize,
                  ),
                ),
              ],
              TextSpan(text: verse.textUthmani),
              TextSpan(
                text: ' ${verse.ayatNumber.toArabicDigits} ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: FontFamily.uthmanicRegular,
                  fontSize: themeCubit.state.textSize,
                  color: themeCubit.state.frColor,
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

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranVersesWidget extends StatelessWidget {
  const QuranVersesWidget({
    required this.themeCubit,
    required this.verses,
    required this.firstKey,
    super.key,
  });

  final QuranBookThemeCubit themeCubit;
  final List<QuranDataVerseEntity> verses;
  final String firstKey;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: FontFamily.uthmanicV2,
          fontSize: themeCubit.state.textSize,
          color: themeCubit.state.frColor,
          height: 2.3,
        ),
        children: verses.map((e) {
          return TextSpan(
            children: [
              if (e.showBismillah)
                TextSpan(
                  text: '${firstKey == e.verseKey ? '' : '\n\n'} ${MqQuranStatic.bismallah} \n',
                ),
              TextSpan(text: e.text),
              TextSpan(
                text: ' ${e.ayatNumber.toArabicDigits} ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.uthmanicRegular,
                  fontSize: themeCubit.state.textSize,
                  color: themeCubit.state.frColor,
                  letterSpacing: -2.5,
                ),
              ),
              if (e.isFirstAyatOfQuran) const TextSpan(text: '\n'),
            ],
          );
        }).toList(),
      ),
    );
  }
}

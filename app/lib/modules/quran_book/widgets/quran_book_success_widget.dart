import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSuccessWidget extends StatelessWidget {
  const QuranBookSuccessWidget(this.items, {super.key});

  final List<QuranDataSamePage> items;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return SliverPadding(
      key: const Key(MqKeys.quranReadView),
      padding: EdgeInsets.symmetric(
        vertical: themeCubit.state.verticalSpaceSize,
        horizontal: themeCubit.state.horizontalSpaceSize,
      ),
      sliver: SliverList.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Localizations.override(
            context: context,
            locale: const Locale('ar'),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.uthmanicV2,
                  fontSize: themeCubit.state.textSize,
                  color: themeCubit.state.frColor,
                  height: 2.3,
                ),
                children: item.verses.map((e) {
                  return TextSpan(
                    children: [
                      if (e.showBismillah)
                        TextSpan(
                          text: '${item.isFirst(e.verseKey) ? '' : '\n\n'} ${MqQuranStatic.bismallah} \n',
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
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Expanded(child: Divider()),
                Text(
                  item.pageNumber.toArabicDigits,
                  style: TextStyle(
                    fontSize: themeCubit.state.textSize,
                    color: themeCubit.state.frColor,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
          );
        },
      ),
    );
  }
}

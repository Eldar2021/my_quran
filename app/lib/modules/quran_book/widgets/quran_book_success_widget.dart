import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: QuranVersesWidget(
              themeCubit: themeCubit,
              verses: item.verses,
              firstKey: item.verses.first.verseKey,
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

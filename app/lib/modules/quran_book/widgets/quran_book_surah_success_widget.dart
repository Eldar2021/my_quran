import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSurahSuccessWidget extends StatelessWidget {
  const QuranBookSurahSuccessWidget(this.items, {super.key});

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
            child: Text(
              '${item.samePage(context)}',
              style: TextStyle(
                fontFamily: FontFamily.uthmanicV2,
                fontSize: themeCubit.state.textSize,
                color: themeCubit.state.frColor,
                height: 2.3,
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
                Localizations.override(
                  context: context,
                  locale: const Locale('ar'),
                  child: Text(
                    item.pageNumber.toArabicDigits,
                    style: TextStyle(
                      fontSize: themeCubit.state.textSize,
                      color: themeCubit.state.frColor,
                    ),
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

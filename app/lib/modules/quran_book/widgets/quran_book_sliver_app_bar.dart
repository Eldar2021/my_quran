import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSliverAppBar extends StatelessWidget {
  const QuranBookSliverAppBar({
    required this.title,
    super.key,
  });

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return SliverAppBar(
      floating: true,
      stretch: true,
      centerTitle: true,
      backgroundColor: themeCubit.state.bgColor,
      foregroundColor: themeCubit.state.frColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: title,
      ),
      actions: [
        IconButton(
          key: const Key(MqKeys.quranReadSettings),
          onPressed: () {
            MqAnalytic.track(AnalyticKey.tapQuranReadSettings);
            MqBottomSheets.showReadSettingsSheet<void>(
              context: context,
              backgroundColor: themeCubit.state.bgColor,
              child: BlocProvider.value(
                value: context.read<QuranBookThemeCubit>(),
                child: const ChangeReadThemeSheetContent(),
              ),
            );
          },
          icon: const Icon(Icons.tune),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

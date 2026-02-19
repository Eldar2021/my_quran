import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSettingsSheet extends StatelessWidget {
  const QuranBookSettingsSheet({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  static void show(BuildContext context) {
    MqAnalytic.track(AnalyticKey.tapQuranReadSettings);
    MqBottomSheets.showScrollableMixModalBottomSheet<void>(
      initialChildSize: 0.87,
      context: context,
      backgroundColor: context.read<QuranBookSettingsCubit>().state.bgColor,
      builder: (context, scrollController) => QuranBookSettingsSheet(
        scrollController: scrollController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      controller: scrollController,
      children: const [
        QuranBookSettingsChangeTextSizeWidget(),
        SizedBox(height: 20),
        QuranFontsSelectionWidget(),
        SizedBox(height: 20),
        QuranSettingsVerticalSpaceChangeWidget(),
        SizedBox(height: 20),
        QuranSettingsHorizontalSpaceChangeWidget(),
        SizedBox(height: 20),
        QuranSettingChangeThemeModeWidget(),
        SizedBox(height: 30),
        QuranBookSettingSaveAndCancelButtons(),
        SizedBox(height: 50),
      ],
    );
  }
}

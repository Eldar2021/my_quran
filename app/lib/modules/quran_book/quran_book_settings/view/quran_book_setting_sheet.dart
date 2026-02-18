import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';
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
      context: context,
      backgroundColor: context.read<QuranBookSettingsCubit>().state.bgColor,
      builder: (context, scrollController) {
        return QuranBookSettingsSheet(
          scrollController: scrollController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      controller: scrollController,
      children: [
        Text(
          context.l10n.textSize,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aDigit.svg(
              colorFilter: _colorFilter(themeCubit.state.frColor),
            ),
            Expanded(
              child: Slider.adaptive(
                value: themeCubit.state.textSize,
                max: 40,
                min: 8,
                onChanged: (v) {
                  context.read<QuranBookSettingsCubit>().changeTextSize(v);
                },
              ),
            ),
            Assets.icons.aDigitBig.svg(
              colorFilter: _colorFilter(themeCubit.state.frColor),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.fontType,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
        const SizedBox(height: 8),
        QuranFontsSelectionWidget(
          initialIndex: themeCubit.state.fontType.indexValue,
          onChanged: (type) {
            context.read<QuranBookSettingsCubit>().changeFontType(type);
          },
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.verticalSpace,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aDigitVerticalSmall.svg(
              colorFilter: _colorFilter(
                themeCubit.state.frColor,
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: themeCubit.state.verticalSpaceSize,
                max: 140,
                onChanged: (v) {
                  context.read<QuranBookSettingsCubit>().changeVerticalSpace(v);
                },
              ),
            ),
            Assets.icons.aDigitVertical.svg(
              colorFilter: _colorFilter(themeCubit.state.frColor),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.horizontalSpace,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aHorizontal.svg(
              colorFilter: _colorFilter(
                themeCubit.state.frColor,
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: themeCubit.state.horizontalSpaceSize,
                max: 140,
                onChanged: (v) {
                  context.read<QuranBookSettingsCubit>().changeHorizontalSpace(v);
                },
              ),
            ),
            Assets.icons.aHorizontalBig.svg(
              colorFilter: _colorFilter(
                themeCubit.state.frColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.screenTheme,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[0],
                foregroundColor: ReadThemeData.frReadThemeColor[0],
                onPressed: () {
                  context.read<QuranBookSettingsCubit>().changeMode(0);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[1],
                foregroundColor: ReadThemeData.frReadThemeColor[1],
                onPressed: () {
                  context.read<QuranBookSettingsCubit>().changeMode(1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlinedButton(
                key: const Key(MqKeys.quranReadSettingsBack),
                onPressed: () => Navigator.pop(context),
                child: Text(context.l10n.cancel),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: ElevatedButton(
                key: const Key(MqKeys.quranReadSettingsSave),
                onPressed: () async {
                  await context.read<QuranBookSettingsCubit>().saveChanges();
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(context.l10n.save),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  ColorFilter _colorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class ChangeReadThemeSheetContent extends StatelessWidget {
  const ChangeReadThemeSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: themeCubit.state.bgColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: const FractionallySizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: themeCubit.state.frColor.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const SizedBox(height: 6, width: 58),
          ),
        ),
        const SizedBox(height: 20),
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
                  context.read<QuranBookThemeCubit>().changeTextSize(v);
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
                  context.read<QuranBookThemeCubit>().changeVerticalSpace(v);
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
                  context.read<QuranBookThemeCubit>().changeHorizontalSpace(v);
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
                  context.read<QuranBookThemeCubit>().changeMode(0);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[1],
                foregroundColor: ReadThemeData.frReadThemeColor[1],
                onPressed: () {
                  context.read<QuranBookThemeCubit>().changeMode(1);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[2],
                foregroundColor: ReadThemeData.frReadThemeColor[2],
                onPressed: () {
                  context.read<QuranBookThemeCubit>().changeMode(2);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[3],
                foregroundColor: ReadThemeData.frReadThemeColor[3],
                onPressed: () {
                  context.read<QuranBookThemeCubit>().changeMode(3);
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
                  await context.read<QuranBookThemeCubit>().saveChanges();
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class ChangeReadThemeSheetContent extends StatelessWidget {
  const ChangeReadThemeSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: readThemeCubit.state.bgColor,
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
    final readThemeCubit = context.watch<ReadThemeCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: readThemeCubit.state.frColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const SizedBox(height: 6, width: 58),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.textSize,
          style: prTextTheme.titleMedium?.copyWith(
            color: readThemeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aDigit.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: readThemeCubit.state.textSize,
                max: 40,
                min: 8,
                onChanged: (v) {
                  context.read<ReadThemeCubit>().changeTextSize(v);
                },
              ),
            ),
            Assets.icons.aDigitBig.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.verticalSpace,
          style: prTextTheme.titleMedium?.copyWith(
            color: readThemeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aDigitVerticalSmall.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: readThemeCubit.state.verticalSpaceSize,
                max: 140,
                onChanged: (v) {
                  context.read<ReadThemeCubit>().changeVerticalSpace(v);
                },
              ),
            ),
            Assets.icons.aDigitVertical.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.horizontalSpace,
          style: prTextTheme.titleMedium?.copyWith(
            color: readThemeCubit.state.frColor,
          ),
        ),
        Row(
          children: [
            Assets.icons.aHorizontal.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: readThemeCubit.state.horizontalSpaceSize,
                max: 140,
                onChanged: (v) {
                  context.read<ReadThemeCubit>().changeHorizontalSpace(v);
                },
              ),
            ),
            Assets.icons.aHorizontalBig.svg(
              colorFilter: _colorFilter(
                readThemeCubit.state.frColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.screenTheme,
          style: prTextTheme.titleMedium?.copyWith(
            color: readThemeCubit.state.frColor,
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
                  context.read<ReadThemeCubit>().changeMode(0);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[1],
                foregroundColor: ReadThemeData.frReadThemeColor[1],
                onPressed: () {
                  context.read<ReadThemeCubit>().changeMode(1);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[2],
                foregroundColor: ReadThemeData.frReadThemeColor[2],
                onPressed: () {
                  context.read<ReadThemeCubit>().changeMode(2);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ThemeModeButton(
                backgroundColor: ReadThemeData.bgReadThemeColor[3],
                foregroundColor: ReadThemeData.frReadThemeColor[3],
                onPressed: () {
                  context.read<ReadThemeCubit>().changeMode(3);
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
                onPressed: () => Navigator.pop(context),
                child: Text(context.l10n.cancel),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<ReadThemeCubit>().saveChanges();
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
    return ColorFilter.mode(
      color,
      BlendMode.srcIn,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSettingsChangeTextSizeWidget extends StatelessWidget {
  const QuranBookSettingsChangeTextSizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
          builder: (context, state) {
            return Text(
              context.l10n.textSize,
              style: prTextTheme.titleMedium?.copyWith(
                color: themeCubit.state.frColor,
              ),
            );
          },
        ),
        Row(
          children: [
            Assets.icons.aDigit.svg(colorFilter: _colorFilter(themeCubit.state.frColor)),
            Expanded(
              child: Slider.adaptive(
                max: 50,
                min: 12,
                value: themeCubit.state.textSize,
                onChanged: context.read<QuranBookSettingsCubit>().changeTextSize,
              ),
            ),
            Assets.icons.aDigitBig.svg(colorFilter: _colorFilter(themeCubit.state.frColor)),
          ],
        ),
      ],
    );
  }

  ColorFilter _colorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }
}

class QuranBookSettingBuilder extends StatelessWidget {
  const QuranBookSettingBuilder({
    required this.builder,
    this.buildWhen,
    super.key,
  });

  final bool Function(
    QuranBookSettingsState,
    QuranBookSettingsState,
  )?
  buildWhen;

  final Widget Function(
    BuildContext,
    QuranBookSettingsState,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
      buildWhen: buildWhen,
      builder: builder,
    );
  }
}

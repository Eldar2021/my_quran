import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranSettingsVerticalSpaceChangeWidget extends StatelessWidget {
  const QuranSettingsVerticalSpaceChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        Text(
          context.l10n.verticalSpace,
          style: prTextTheme.titleMedium?.copyWith(
            color: themeCubit.state.frColor,
          ),
        ),
      ],
    );
  }

  ColorFilter _colorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }
}

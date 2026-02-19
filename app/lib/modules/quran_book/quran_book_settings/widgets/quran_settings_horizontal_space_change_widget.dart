import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranSettingsHorizontalSpaceChangeWidget extends StatelessWidget {
  const QuranSettingsHorizontalSpaceChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Assets.icons.aHorizontal.svg(
              colorFilter: _colorFilter(themeCubit.state.frColor),
            ),
            Expanded(
              child: Slider.adaptive(
                max: 100,
                value: themeCubit.state.horizontalSpaceSize,
                onChanged: context.read<QuranBookSettingsCubit>().changeHorizontalSpace,
              ),
            ),
            Assets.icons.aHorizontalBig.svg(
              colorFilter: _colorFilter(themeCubit.state.frColor),
            ),
          ],
        ),
        Text(
          context.l10n.horizontalSpace,
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

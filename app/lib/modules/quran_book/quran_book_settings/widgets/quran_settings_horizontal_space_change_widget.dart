import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranSettingsHorizontalSpaceChangeWidget extends StatelessWidget {
  const QuranSettingsHorizontalSpaceChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuranBookSettingBuilder.changeThemeMode(
          builder: (context, bgColor, frColor) {
            return Text(
              context.l10n.horizontalSpace,
              style: prTextTheme.titleMedium?.copyWith(color: frColor),
            );
          },
        ),
        Row(
          children: [
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aHorizontal.svg(colorFilter: _colorFilter(frColor));
              },
            ),
            Expanded(
              child: QuranBookSettingBuilder.changeSpace(
                builder: (context, horizontal, vertical) {
                  return Slider.adaptive(
                    max: 70,
                    value: horizontal,
                    onChanged: context.read<QuranBookSettingsCubit>().changeHorizontalSpace,
                  );
                },
              ),
            ),
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aHorizontalBig.svg(colorFilter: _colorFilter(frColor));
              },
            ),
          ],
        ),
      ],
    );
  }

  ColorFilter _colorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }
}

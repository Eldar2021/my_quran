import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranSettingsVerticalSpaceChangeWidget extends StatelessWidget {
  const QuranSettingsVerticalSpaceChangeWidget({super.key});

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
              context.l10n.verticalSpace,
              style: prTextTheme.titleMedium?.copyWith(color: frColor),
            );
          },
        ),
        Row(
          children: [
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aDigitVerticalSmall.svg(colorFilter: _colorFilter(frColor));
              },
            ),
            Expanded(
              child: QuranBookSettingBuilder.changeSpace(
                builder: (context, horizontal, vertical) {
                  return Slider.adaptive(
                    value: vertical,
                    max: 100,
                    onChanged: context.read<QuranBookSettingsCubit>().changeVerticalSpace,
                  );
                },
              ),
            ),
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aDigitVertical.svg(colorFilter: _colorFilter(frColor));
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

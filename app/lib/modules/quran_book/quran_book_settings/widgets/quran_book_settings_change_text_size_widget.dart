import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSettingsChangeTextSizeWidget extends StatelessWidget {
  const QuranBookSettingsChangeTextSizeWidget({super.key});

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
              context.l10n.textSize,
              style: prTextTheme.titleMedium?.copyWith(color: frColor),
            );
          },
        ),
        Row(
          children: [
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aDigit.svg(colorFilter: _colorFilter(frColor));
              },
            ),
            Expanded(
              child: QuranBookSettingBuilder.changeTextTheme(
                builder: (context, textSize, fontType) {
                  return Slider.adaptive(
                    max: 50,
                    min: 12,
                    value: textSize,
                    onChanged: context.read<QuranBookSettingsCubit>().changeTextSize,
                  );
                },
              ),
            ),
            QuranBookSettingBuilder.changeThemeMode(
              builder: (context, bgColor, frColor) {
                return Assets.icons.aDigitBig.svg(colorFilter: _colorFilter(frColor));
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

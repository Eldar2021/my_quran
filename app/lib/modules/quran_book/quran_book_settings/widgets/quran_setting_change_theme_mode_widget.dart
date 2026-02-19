import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranSettingChangeThemeModeWidget extends StatelessWidget {
  const QuranSettingChangeThemeModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}

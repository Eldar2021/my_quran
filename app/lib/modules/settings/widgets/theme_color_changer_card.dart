import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class ThemeColorChangerCard extends StatelessWidget {
  const ThemeColorChangerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OrangeThemeCard(
          title: context.l10n.orange,
          key: Key(MqKeys.settingsThemeColorName('Orange')),
          isActive: colorScheme.primary == AppColors.tomato,
          onChanged: ({value}) => _changeThemeColor(true, context),
        ),
        const SizedBox(height: 12),
        BlueThemeCard(
          title: context.l10n.blue,
          key: Key(MqKeys.settingsThemeColorName('Blue')),
          isActive: colorScheme.primary == AppColors.tomato,
          onChanged: ({value}) => _changeThemeColor(false, context),
        ),
      ],
    );
  }

  void _changeThemeColor(bool isOrange, BuildContext context) {
    context.read<AppThemeCubit>().changeColor(isOrange: isOrange);
  }
}

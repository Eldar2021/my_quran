import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<AppThemeCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return ScaffoldWithBgImage(
      appBar: AppBar(key: const Key(MqKeys.settingsThemePage), title: Text(context.l10n.theme)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              key: Key(
                colorScheme.brightness == Brightness.light ? MqKeys.settingsThemeDark : MqKeys.settingsThemeLight,
              ),
              value: themeCubit.state.themeData.brightness == Brightness.dark,
              title: Text(context.l10n.darkMode),
              secondary: Assets.icons.lightDark.svg(
                colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
              ),
              onChanged: (v) {
                MqAnalytic.track(
                  AnalyticKey.selectThemeMode,
                  params: {'mode': v == true ? Brightness.light.name : Brightness.dark.name},
                );
                context.read<AppThemeCubit>().changeMode(isDark: v);
              },
            ),
            const SizedBox(height: 26),
            OrangeThemeCard(
              title: context.l10n.orange,
              key: Key(MqKeys.settingsThemeColorName('Orange')),
              isActive: colorScheme.primary == AppColors.tomato,
              onChanged: ({value}) {
                context.read<AppThemeCubit>().changeColor(isOrange: true);
              },
            ),
            const SizedBox(height: 13),
            BlueThemeCard(
              title: context.l10n.blue,
              key: Key(MqKeys.settingsThemeColorName('Blue')),
              isActive: colorScheme.primary == AppColors.tomato,
              onChanged: ({value}) {
                context.read<AppThemeCubit>().changeColor(isOrange: false);
              },
            ),
            const Spacer(),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(context.l10n.saveChanges)),
            SizedBox(height: AppSpacing.bottomSpace),
          ],
        ),
      ),
    );
  }
}

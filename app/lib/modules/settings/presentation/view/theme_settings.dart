import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsThemePage),
        title: Text(context.l10n.profileChangeTheme),
        actions: [
          IconButton(
            key: Key(
              appCubit.state.theme.brightness == Brightness.light
                  ? MqKeys.settingsThemeDark
                  : MqKeys.settingsThemeLight,
            ),
            onPressed: () {
              MqAnalytic.track(
                AnalyticKey.selectThemeMode,
                params: {
                  'mode': appCubit.state.theme.brightness == Brightness.light
                      ? Brightness.light.name
                      : Brightness.dark.name,
                },
              );
              context.read<AppCubit>().changeMode(
                    isDark: context.read<AppCubit>().state.theme.brightness == Brightness.light,
                  );
            },
            icon: appCubit.state.theme.brightness == Brightness.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        itemCount: TargetColor.values.length,
        itemBuilder: (BuildContext context, int index) {
          final targetColor = TargetColor.fromIndex(index);
          return Card(
            child: ListTile(
              key: Key(MqKeys.settingsThemeColorName(targetColor.displayName(context))),
              leading: Icon(
                Icons.color_lens_rounded,
                color: targetColor.color,
              ),
              title: Text(targetColor.displayName(context)),
              onTap: () {
                MqAnalytic.track(
                  AnalyticKey.selectThemeColor,
                  params: {'color': targetColor.color},
                );
                context.read<AppCubit>().changeColor(targetColor.caheIindex, targetColor.color);
              },
            ),
          );
        },
      ),
    );
  }
}

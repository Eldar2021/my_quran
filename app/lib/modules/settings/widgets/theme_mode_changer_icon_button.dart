import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';

class ThemeModeChangerIconButton extends StatelessWidget {
  const ThemeModeChangerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AppThemeCubit, AppTheme>(
      builder: (context, state) {
        final isDark = state.themeData.brightness == Brightness.dark;
        return IconButton(
          key: Key(isDark ? MqKeys.settingsThemeDark : MqKeys.settingsThemeLight),
          onPressed: () => _changeThemeMode(!isDark, context),
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: colorScheme.onSurface,
          ),
        );
      },
    );
  }

  void _changeThemeMode(bool isDark, BuildContext context) {
    context.read<AppThemeCubit>().changeMode(isDark: isDark);
  }
}

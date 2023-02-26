import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/logic/app_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profileChangeTheme),
        actions: [
          IconButton(
            key: const Key('settings-theme-theme-button'),
            onPressed: () {
              context.read<AppCubit>().changeMode(
                    isDark: context.read<AppCubit>().state.theme.brightness == Brightness.light,
                  );
            },
            icon: appCubit.state.theme.brightness == Brightness.light
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        itemCount: targetColors.length,
        itemBuilder: (BuildContext context, int index) {
          final targetColor = targetColors[index];
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.color_lens_rounded,
                color: targetColor,
              ),
              title: Text(targetColor?.value.toString() ?? ''),
              onTap: () => targetColor != null ? context.read<AppCubit>().changeColor(index, targetColor) : {},
            ),
          );
        },
      ),
    );
  }
}

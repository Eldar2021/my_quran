import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class AppSettingsView extends StatefulWidget {
  const AppSettingsView({super.key});

  @override
  State<AppSettingsView> createState() => _AppSettingsViewState();
}

class _AppSettingsViewState extends State<AppSettingsView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.customApp),
        actions: const [
          ThemeModeChangerIconButton(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          Text(
            context.l10n.theme,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const ThemeColorChangerCard(),
          const SizedBox(height: 28),
          const UnauthenticatedLanguageSettings(),
          const SizedBox(height: 28),
          const UnauthenticatedGenderSettings(),
          const SizedBox(height: 28),
          const ToggleNotification(),
          SizedBox(height: AppSpacing.bottomSpace),
        ],
      ),
    );
  }
}

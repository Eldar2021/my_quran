import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsView),
        title: InkWell(
          onLongPress: () => context.pushNamed(AppRouter.devModeView),
          child: Text(l10n.profileSettings),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            key: const Key(MqKeys.settingsGender),
            title: Text(l10n.profileGender),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(authCubit.state.user?.gender == Gender.female ? l10n.female : l10n.male),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => context.goNamed(AppRouter.genderSettings),
          ),
          ListTile(
            key: const Key(MqKeys.settingsLanguage),
            title: Text(l10n.profileLang),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppConst.getName(appCubit.state.currentLocale.toLanguageTag())),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => context.goNamed(AppRouter.langSettings),
          ),
          ListTile(
            key: const Key(MqKeys.settingsTheme),
            title: Text(l10n.profileTheme),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.goNamed(AppRouter.themeSettings),
          ),
          ListTile(
            key: const Key(MqKeys.settingsAboutUs),
            title: Text(l10n.aboutUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.goNamed(AppRouter.aboutUs),
          ),
          ListTile(
            key: const Key(MqKeys.settingsContactUs),
            title: Text(l10n.contactUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.goNamed(AppRouter.contactUs),
          ),
          ListTile(
            key: const Key(MqKeys.settingsDevelopers),
            title: Text(l10n.profileForDevelopers),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.goNamed(AppRouter.developers),
          ),
        ],
      ),
    );
  }
}

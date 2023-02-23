import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/user/user_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        key: const Key('settings-view'),
        title: Text(l10n.lang),
      ),
      body: ListView(
        children: [
          ListTile(
            key: const Key('settings-gender-view'),
            title: Text(l10n.profileGender),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(authCubit.state.user?.gender == Gender.female ? l10n.female : l10n.male),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, AppRouter.genderSettings),
          ),
          ListTile(
            key: const Key('settings-language-view'),
            title: Text(l10n.profileLang),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(appCubit.localService.getName(appCubit.state.currentLocale.toLanguageTag())),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, AppRouter.langSettings),
          ),
          ListTile(
            key: const Key('settings-theme-view'),
            title: Text(l10n.profileTheme),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.themeSettings),
          ),
          ListTile(
            key: const Key('settings-about-us-view'),
            title: Text(l10n.aboutUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.aboutUs),
          ),
          ListTile(
            key: const Key('settings-feedback-view'),
            title: Text(l10n.feedback),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async => AppLaunch.sendEmail(
              'eldiiaralmazbekov@gmail.com',
              snackBarText: l10n.feedBackSms,
              context: context,
            ),
          ),
          ListTile(
            key: const Key('settings-developers-view'),
            title: Text(l10n.profileForDevelopers),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.developers),
          ),
        ],
      ),
    );
  }
}

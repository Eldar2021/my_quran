import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();
    final user = authCubit.state.user;
    final username = user?.username ?? '';
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsView),
        title: Text(username, style: context.titleMedium),
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
            onTap: () {
              MqAnalytic.track(AnalyticKey.goGenderPage);
              context.pushNamed(AppRouter.genderSettings);
            },
          ),
          ListTile(
            key: const Key(MqKeys.settingsLanguage),
            title: Text(l10n.profileLang),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizationHelper.getName(
                    authCubit.state.currentLocale.toLanguageTag(),
                  ),
                ),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {
              MqAnalytic.track(AnalyticKey.selectLanguage);
              context.pushNamed(AppRouter.langSettings);
            },
          ),
          ListTile(
            key: const Key(MqKeys.settingsTheme),
            title: Text(l10n.profileTheme),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              MqAnalytic.track(AnalyticKey.goThemePage);
              context.pushNamed(AppRouter.themeSettings);
            },
          ),
          ListTile(
            key: const Key(MqKeys.settingsAboutUs),
            title: Text(l10n.aboutUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              MqAnalytic.track(AnalyticKey.goAboutUsPage);
              context.pushNamed(AppRouter.aboutUs);
            },
          ),
          ListTile(
            key: const Key(MqKeys.settingsContactUs),
            title: Text(l10n.contactUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              MqAnalytic.track(AnalyticKey.goContactUsPage);
              context.pushNamed(AppRouter.contactUs);
            },
          ),
          ListTile(
            key: const Key(MqKeys.settingsDevelopers),
            title: Text(l10n.profileForDevelopers),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              MqAnalytic.track(AnalyticKey.goDevelopersPage);
              context.pushNamed(AppRouter.developers);
            },
          ),
          if (authCubit.state.isAuthedticated)
            ListTile(
              key: const Key(MqKeys.logoutButton),
              title: Text(context.l10n.logout),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (!state.isAuthedticated) {
                          context.go('/login');
                        }
                      },
                      child: ConfirmationWidget(
                        key: const Key(MqKeys.confirmLogoutButton),
                        title: context.l10n.logout,
                        content: context.l10n.signOutContext,
                        onPressed: () {
                          MqAnalytic.track(AnalyticKey.tapLogout);
                          authCubit.logout();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          if (authCubit.state.isAuthedticated)
            ListTile(
              key: const Key(MqKeys.deleteAccountButton),
              title: Text(context.l10n.deleteAccount),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (!state.isAuthedticated) {
                          context.go('/login');
                        }
                      },
                      child: ConfirmationWidget(
                        key: const Key(MqKeys.confirmDeleteAccountButton),
                        title: context.l10n.deleteAccount,
                        content: context.l10n.confirmDeleteAccount,
                        onPressed: () {
                          MqAnalytic.track(AnalyticKey.tapDeleteAccount);
                          authCubit.deleteAccount();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ListTile(
            title: Text(context.l10n.version),
            trailing: InkWell(
              onLongPress: () {
                MqAnalytic.track(AnalyticKey.goDevMode);
                context.pushNamed(AppRouter.devModeView);
              },
              child: Text(context.watch<AppCubit>().state.appVersion),
            ),
          ),
        ],
      ),
    );
  }
}

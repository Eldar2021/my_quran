import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class SettingActionsWidget extends StatelessWidget {
  const SettingActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final authCubit = context.watch<AuthCubit>();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const SizedBox(height: 20),
        Text(context.l10n.generalMenu, style: prTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        DrawerTile(
          key: const Key(MqKeys.settingsGenderLang),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goGenderPage);
            context.pushNamed(AppRouter.customAppSettings);
          },
          icon: Icon(Icons.translate, size: 17, color: colorScheme.primary),
          title: context.l10n.customApp,
        ),
        DrawerTile(
          key: const Key(MqKeys.settingsTheme),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goThemePage);
            context.pushNamed(AppRouter.themeSettings);
          },
          icon: Icon(Icons.sunny, size: 17, color: colorScheme.primary),
          title: context.l10n.theme,
        ),
        DrawerTile(
          key: const Key(MqKeys.settingsAboutUs),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goAboutUsPage);
            context.pushNamed(AppRouter.aboutUs);
          },
          icon: Assets.icons.users.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
          title: context.l10n.aboutUs,
        ),
        DrawerTile(
          key: const Key(MqKeys.settingsContactUs),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goContactUsPage);
            context.pushNamed(AppRouter.contactUs);
          },
          icon: Assets.icons.phone.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
          title: context.l10n.contactUs,
        ),
        Builder(
          builder: (ctx) {
            return DrawerTile(
              onTap: () => AppShare.shareUri(context: ctx, url: ApiConst.oneLink),
              icon: Assets.icons.shareFill.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
              title: context.l10n.share,
            );
          },
        ),
        BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
          builder: (context, state) {
            if (state.isDonaitonEnable) {
              return DrawerTile(
                onTap: () => context.pushNamed(AppRouter.donation),
                icon: Assets.icons.donate.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
                title: context.l10n.donate,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        DrawerTile(
          key: const Key(MqKeys.createHatim),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goCreateHatim);
            Navigator.pop(context);
            context.pushNamed(AppRouter.createHatim);
          },
          icon: Assets.icons.createHatim.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
          title: context.l10n.createHatim,
        ),
        DrawerTile(
          key: const Key(MqKeys.settingsDevelopers),
          onTap: () {
            MqAnalytic.track(AnalyticKey.goDevelopersPage);
            context.pushNamed(AppRouter.developers);
          },
          icon: Assets.icons.developers.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
          title: context.l10n.forDevelopers,
        ),
        if (authCubit.state.isAuthedticated)
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (!state.isAuthedticated) {
                context.go('/login');
              }
            },
            child: DrawerTile(
              key: const Key(MqKeys.logoutButton),
              onTap: () {
                MqBottomSheets.showConfirmSheet<void>(
                  context: context,
                  title: context.l10n.logout,
                  content: context.l10n.confirmLogout,
                  confirmText: context.l10n.yes,
                  cancelText: context.l10n.cancel,
                  confirmKey: MqKeys.confirmLogoutButtonYes,
                  onConfirm: () {
                    MqAnalytic.track(AnalyticKey.tapLogout);
                    authCubit.logout();
                  },
                  onCancel: () => Navigator.pop(context),
                );
              },
              icon: Assets.icons.logout.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
              title: context.l10n.logout,
            ),
          ),
        if (authCubit.state.isAuthedticated)
          DrawerTile(
            onTap: () {
              MqBottomSheets.showConfirmSheet<void>(
                context: context,
                title: context.l10n.deleteAccount,
                content: context.l10n.confirmDeleteAccount,
                confirmText: context.l10n.yes,
                cancelText: context.l10n.cancel,
                onConfirm: () {
                  MqAnalytic.track(AnalyticKey.tapDeleteAccount);
                  authCubit.deleteAccount();
                },
                onCancel: () => Navigator.pop(context),
              );
            },
            icon: Assets.icons.trash.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
            title: context.l10n.deleteAccount,
          ),
      ],
    );
  }
}

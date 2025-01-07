import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/config/config.dart';
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
        Text(
          'General menu',
          style: prTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        DrawerTile(
          onTap: () {
            MqAnalytic.track(AnalyticKey.goGenderPage);
            context.pushNamed(AppRouter.customAppSettings);
          },
          icon: Icon(
            Icons.translate,
            size: 17,
            color: colorScheme.primary,
          ),
          title: context.l10n.customApp,
        ),
        DrawerTile(
          onTap: () {
            MqAnalytic.track(AnalyticKey.goThemePage);
            context.pushNamed(AppRouter.themeSettings);
          },
          icon: Icon(
            Icons.sunny,
            size: 17,
            color: colorScheme.primary,
          ),
          title: context.l10n.theme,
        ),
        DrawerTile(
          onTap: () {
            MqAnalytic.track(AnalyticKey.goAboutUsPage);
            context.pushNamed(AppRouter.aboutUs);
          },
          icon: Assets.icons.users.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          title: context.l10n.aboutUs,
        ),
        DrawerTile(
          onTap: () {
            MqAnalytic.track(AnalyticKey.goContactUsPage);
            context.pushNamed(AppRouter.contactUs);
          },
          icon: Assets.icons.phone.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          title: context.l10n.contactUs,
        ),
        DrawerTile(
          onTap: () {},
          icon: Assets.icons.shareFill.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          title: context.l10n.share,
        ),
        DrawerTile(
          onTap: () {
            MqAnalytic.track(AnalyticKey.goDevelopersPage);
            context.pushNamed(AppRouter.developers);
          },
          icon: Assets.icons.developers.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
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
              onTap: () {
                MqBottomSheets.showConfirmSheet<void>(
                  context: context,
                  title: context.l10n.logout,
                  content: context.l10n.confirmLogout,
                  confirmText: context.l10n.yes,
                  cancelText: context.l10n.cancel,
                  onConfirm: () {
                    MqAnalytic.track(AnalyticKey.tapLogout);
                    authCubit.logout();
                  },
                  onCancel: () => Navigator.pop(context),
                );
              },
              icon: Assets.icons.logout.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
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
            icon: Assets.icons.trash.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            title: context.l10n.deleteAccount,
          ),
      ],
    );
  }
}

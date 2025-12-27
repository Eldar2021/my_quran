import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class MoreActions extends StatelessWidget {
  const MoreActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: colors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            DrawerTile(
              key: const Key(MqKeys.settingsGenderLang),
              title: context.l10n.customApp,
              onTap: () => context.pushNamed(AppRouter.appSettings),
              icon: Icon(
                Icons.settings,
                color: colors.primary,
              ),
            ),
            DrawerTile(
              key: const Key(MqKeys.settingsAboutUs),
              title: context.l10n.aboutUs,
              onTap: () => context.pushNamed(AppRouter.aboutUs),
              icon: Assets.icons.users.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            DrawerTile(
              key: const Key(MqKeys.settingsContactUs),
              title: context.l10n.contactUs,
              onTap: () => context.pushNamed(AppRouter.contactUs),
              icon: Assets.icons.phone.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            DrawerTile(
              title: context.l10n.share,
              onTap: () => AppShare.shareUri(
                context: context,
                url: ApiConst.oneLink,
              ),
              icon: Assets.icons.shareFill.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            DrawerTile(
              key: const Key(MqKeys.settingsDevelopers),
              title: context.l10n.forDevelopers,
              onTap: () => context.pushNamed(AppRouter.developers),
              icon: Assets.icons.developers.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
              builder: (context, state) {
                if (state.isDonaitonEnable) {
                  return DrawerTile(
                    title: context.l10n.donate,
                    onTap: () => context.pushNamed(AppRouter.donation),
                    icon: Assets.icons.donate.svg(
                      colorFilter: ColorFilter.mode(
                        colors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
              builder: (context, state) {
                return DrawerTile(
                  title: '${ApiConst.appName} ${state.version}(${state.buildNumber})',
                  icon: CircleAvatar(
                    backgroundImage: Assets.images.appIcon.provider(),
                  ),
                  trailing: const SizedBox.shrink(),
                  onLongPress: () => context.pushNamed(AppRouter.devModeView),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

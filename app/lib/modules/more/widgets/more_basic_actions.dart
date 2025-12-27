import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class MoreBasicActions extends StatelessWidget {
  const MoreBasicActions({super.key});

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
            /// Theme, if auth state is unauthenticated, show gender selection, language selection, Notification settings
            DrawerTile(
              key: const Key(MqKeys.settingsGenderLang),
              title: context.l10n.customApp,
              onTap: () {},
              icon: Icon(
                Icons.settings,
                color: colors.primary,
              ),
            ),

            /// About Us
            DrawerTile(
              key: const Key(MqKeys.settingsAboutUs),
              title: context.l10n.aboutUs,
              onTap: () {},
              icon: Assets.icons.users.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            /// Contact Us
            DrawerTile(
              key: const Key(MqKeys.settingsContactUs),
              title: context.l10n.contactUs,
              onTap: () {},
              icon: Assets.icons.phone.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            /// Share app
            DrawerTile(
              title: context.l10n.share,
              onTap: () {},
              icon: Assets.icons.shareFill.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            /// For Developers
            DrawerTile(
              key: const Key(MqKeys.settingsDevelopers),
              title: context.l10n.forDevelopers,
              onTap: () {},
              icon: Assets.icons.developers.svg(
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            /// Donation
            BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
              builder: (context, state) {
                if (state.isDonaitonEnable) {
                  return DrawerTile(
                    title: context.l10n.donate,
                    onTap: () {},
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

            /// About App
            DrawerTile(
              title: context.l10n.aboutApp,
              onTap: () {},
              icon: Icon(
                Icons.info_outline,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

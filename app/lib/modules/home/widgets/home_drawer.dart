import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/cubit/remote_config_cubit.dart';
import 'package:my_quran/config/router/app_router.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({this.closeDrawer, super.key});

  final void Function()? closeDrawer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final size = MediaQuery.sizeOf(context);
    return Drawer(
      key: const Key(MqKeys.settingsView),
      width: size.width * 0.85,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(40))),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(
              iconSize: 30,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              padding: const EdgeInsets.only(left: 20),
              onPressed: closeDrawer,
              icon: const Icon(Icons.close),
            ),
            const SizedBox(height: 10),
            const UserProfileTile(),
            const Expanded(child: SettingActionsWidget()),
            Center(
              child: InkWell(
                onLongPress: () {
                  MqAnalytic.track(AnalyticKey.goDevMode);
                  context.pushNamed(AppRouter.devModeView);
                },
                child: BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                  builder: (context, state) {
                    return Text(
                      '${context.l10n.version} ${state.version}',
                      style: prTextTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    this.closeDrawer,
    super.key,
  });

  final void Function()? closeDrawer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final appCubit = context.watch<AppCubit>();
    final size = MediaQuery.sizeOf(context);
    return Drawer(
      width: size.width * 0.85,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(
              iconSize: 30,
              color: colorScheme.onSurface.withOpacity(0.5),
              padding: const EdgeInsets.only(left: 20),
              onPressed: closeDrawer,
              icon: const Icon(Icons.close),
            ),
            const SizedBox(height: 10),
            const UserProfileTile(),
            const Expanded(
              child: SettingActionsWidget(),
            ),
            Center(
              child: Text(
                '${context.l10n.version} ${appCubit.state.appVersion}',
                style: prTextTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

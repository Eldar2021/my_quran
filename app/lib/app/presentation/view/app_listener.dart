import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class AppListener extends StatelessWidget {
  const AppListener({
    required this.child,
    required this.navigationKey,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (p, c) => p.appVersionStatus != c.appVersionStatus,
      listener: (context, state) {
        if (state.appVersionStatus is YesRecommendedVersion) {
          _showUpdateDialog(context);
        } else if (state.appVersionStatus is YesRequiredVersion) {
          _showUpdateDialog(context, forceUpdate: true);
        }
      },
      child: child,
    );
  }

  void _showUpdateDialog(BuildContext context, {bool forceUpdate = false}) {
    final ctx = navigationKey.currentState!.overlay!.context;
    showAdaptiveDialog<void>(
      context: ctx,
      barrierDismissible: !forceUpdate,
      builder: (ctx) {
        return PopScope(
          canPop: !forceUpdate,
          child: AlertDialog.adaptive(
            title: Text(
              ctx.l10n.appUpdateAvailable,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              forceUpdate ? ctx.l10n.requiredVersionDescription : ctx.l10n.recommendedVersionDescription,
            ),
            actions: [
              if (!forceUpdate)
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    ctx.l10n.remindMeLater,
                    textAlign: TextAlign.center,
                  ),
                ),
              TextButton(
                onPressed: () => AppLaunch.launchURL(_getPlatformAppStoreLink),
                child: Text(
                  ctx.l10n.updateNow,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String get _getPlatformAppStoreLink {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.alee.my_quran&hl=en';
    } else {
      return 'https://apps.apple.com/kg/app/my-quran/id1671645027';
    }
  }
}

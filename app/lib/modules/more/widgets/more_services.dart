import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/show/alerts.dart';

class MoreServices extends StatelessWidget {
  const MoreServices({
    required this.enableCreateHatims,
    required this.enableJoinHatims,
    super.key,
  });

  final bool enableCreateHatims;
  final bool enableJoinHatims;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ServiceCard(
            title: context.l10n.createHatim,
            onTap: () => _createHatim(context),
            icon: Assets.icons.createHatim.svg(
              colorFilter: ColorFilter.mode(
                colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ServiceCard(
            title: context.l10n.readQuran,
            onTap: () => _readQuran(context),
            icon: Assets.icons.quran.svg(
              colorFilter: ColorFilter.mode(
                colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ServiceCard(
            title: context.l10n.listenQuran,
            onTap: () => _listenQuran(context),
            icon: Assets.icons.listenQuran.svg(
              colorFilter: ColorFilter.mode(
                colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ServiceCard(
            title: context.l10n.joinToHatim,
            onTap: () => _joinToHatim(context),
            icon: Assets.icons.book.svg(
              colorFilter: ColorFilter.mode(
                colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listenQuran(BuildContext context) {
    sectionNavigatorKeyMain.currentState?.goBranch(2);
  }

  void _readQuran(BuildContext context) {
    sectionNavigatorKeyMain.currentState?.goBranch(1);
  }

  void _createHatim(BuildContext context) {
    if (enableCreateHatims) {
      context.pushNamed(AppRouter.createHatim);
    } else {
      AppAlert.showErrorDialog(
        context,
        title: Text(context.l10n.createKhatimUnavailable),
        errorText: context.l10n.createKhatimContactPrompt(context.l10n.contactUs),
        buttonText: context.l10n.ok,
      );
    }
  }

  void _joinToHatim(BuildContext context) {
    if (enableJoinHatims) {
      sectionNavigatorKeyMain.currentState?.goBranch(0, initialLocation: true);
    } else {
      AppAlert.showErrorDialog(
        context,
        title: Text(context.l10n.joinKhatimUnavailable),
        errorText: context.l10n.joinKhatimLoginPrompt,
        buttonText: context.l10n.ok,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class HomeShareTile extends StatelessWidget {
  const HomeShareTile({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () => AppShare.shareUri(
        context: context,
        url: ApiConst.oneLink,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: CircleAvatar(
        backgroundColor: colorScheme.onInverseSurface,
        child: Assets.icons.shareFill.svg(
          colorFilter: ColorFilter.mode(
            colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        context.l10n.shareApp,
        style: prTextTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

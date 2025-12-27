import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

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
            onTap: () {},
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
            onTap: () {},
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
            onTap: () {},
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
            onTap: () {},
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
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';

class MainView extends StatelessWidget {
  const MainView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              key: const Key(MqKeys.home),
              label: context.l10n.home,
              activeIcon: Assets.icons.prayingMan.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.prayingMan.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              key: const Key(MqKeys.quaranRead),
              label: context.l10n.quran,
              activeIcon: Assets.icons.quran.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.quran.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              key: const Key(MqKeys.quranAudio),
              label: context.l10n.listening,
              activeIcon: Assets.icons.listenQuran.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.listenQuran.svg(
                width: 27,
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              key: const Key(MqKeys.morePageKey),
              label: context.l10n.more,
              activeIcon: Assets.icons.more.svg(
                width: 27,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.more.svg(
                width: 27,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

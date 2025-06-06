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
          boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.1), blurRadius: 2)],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          items: [
            BottomNavigationBarItem(
              key: const Key(MqKeys.quaranRead),
              activeIcon: Assets.icons.quran.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
              icon: Assets.icons.quran.svg(colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn)),
              label: context.l10n.quran,
            ),
            BottomNavigationBarItem(
              key: const Key(MqKeys.home),
              activeIcon: Assets.icons.prayingMan.svg(
                width: 27,
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              ),
              icon: Assets.icons.prayingMan.svg(
                width: 27,
                colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
              ),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              key: const Key(MqKeys.quranAudio),
              activeIcon: Assets.icons.listenQuran.svg(
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              ),
              icon: Assets.icons.listenQuran.svg(colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn)),
              label: context.l10n.listening,
            ),
          ],
          onTap: _onTap,
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }
}

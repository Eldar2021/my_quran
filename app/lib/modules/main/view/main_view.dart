import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
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
              color: context.colors.shadow.withOpacity(0.1),
              blurRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: Assets.icons.quran.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.quran.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
              label: context.l10n.quran,
            ),
            BottomNavigationBarItem(
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
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Assets.icons.listenQuran.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: Assets.icons.listenQuran.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
              label: context.l10n.audioQuran,
            ),
          ],
          onTap: _onTap,
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';

class MainView extends StatelessWidget {
  const MainView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onTap,
        selectedIndex: navigationShell.currentIndex,
        destinations: <Widget>[
          NavigationDestination(
            key: const Key(MqKeys.home),
            icon: const Icon(FontAwesomeIcons.house),
            label: context.l10n.bottomHome,
          ),
          NavigationDestination(
            key: const Key(MqKeys.quaranRead),
            icon: const Icon(FontAwesomeIcons.bookQuran),
            label: context.l10n.bottomQuran,
          ),
          NavigationDestination(
            key: const Key(MqKeys.quranAudio),
            icon: const Icon(FontAwesomeIcons.headphonesSimple),
            label: context.l10n.audioQuran,
          ),
          NavigationDestination(
            key: const Key(MqKeys.settings),
            icon: const Icon(FontAwesomeIcons.userGear),
            label: context.l10n.bottomProfile,
          ),
        ],
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

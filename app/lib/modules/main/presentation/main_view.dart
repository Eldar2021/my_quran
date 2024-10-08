import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/constants/contants.dart';

class MainView extends StatelessWidget {
  const MainView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Assets.icons.notebook.svg(
              key: const Key(MqKeys.quaranRead),
              height: 28,
              width: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Assets.icons.home.svg(
              key: const Key(MqKeys.home),
              height: 28,
              width: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Assets.icons.headphones.svg(
              key: const Key(MqKeys.quranAudio),
              width: 28,
              height: 28,
            ),
          ),
        ],
        onTap: _onTap,
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

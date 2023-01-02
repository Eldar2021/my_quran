import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/modules/modules.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    context.read<AuthCubit>().getTotalHatimAndTotalRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: const MainScreen([
        QuranView(),
        HomeView(),
        SettingsView(),
      ]),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[context.watch<MainCubit>().state],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: context.read<MainCubit>().change,
        selectedIndex: context.watch<MainCubit>().state,
        destinations: <Widget>[
          NavigationDestination(
            key: const Key('quran'),
            icon: const Icon(Icons.book_rounded),
            label: context.l10n.bottomQuran,
          ),
          NavigationDestination(
            key: const Key('home'),
            icon: const Icon(Icons.home),
            label: context.l10n.bottomHome,
          ),
          NavigationDestination(
            key: const Key('profile'),
            icon: const Icon(Icons.person),
            label: context.l10n.bottomProfile,
          ),
        ],
      ),
    );
  }
}

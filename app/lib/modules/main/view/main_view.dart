import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    context.read<HomeCubit>().getData(context.read<AuthCubit>().state.user!.accessToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: const MainScreen([
        HomeView(),
        QuranView(),
        QuranAudioView(),
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
            key: const Key('home'),
            icon: const Icon(Icons.home),
            label: context.l10n.bottomHome,
          ),
          NavigationDestination(
            key: const Key('quran'),
            icon: const Icon(Icons.book_rounded),
            label: context.l10n.bottomQuran,
          ),
          NavigationDestination(
            key: const Key('quran-audio'),
            icon: const Icon(Icons.headset_mic),
            label: context.l10n.bottomQuran,
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

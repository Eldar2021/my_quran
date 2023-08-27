import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

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
}

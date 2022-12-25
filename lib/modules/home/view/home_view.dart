import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/home/logic/home_cubit.dart';
import 'package:hatim/modules/home/view/page_view_item.dart';
import 'package:hatim/modules/modules.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const List<Widget> myTabs = <Widget>[
    PageViewCard(page: 'Juz', key: Key('juz-items')),
    PageViewCard(page: 'Surah', key: Key('surah-items')),
  ];

  TabBar get tabBar => const TabBar(
        tabs: myTabs,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.pushNamed(context, AppRouter.settingsPage);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: tabBar.preferredSize,
            child: tabBar,
          ),
        ),
        body: BlocProvider(
          create: (context) => HomeCubit(),
          child: HomeBody(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.read<AuthCubit>().logout().whenComplete(
                  () => Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (context) => const LoginView()),
                    (route) => false,
                  ),
                );
          },
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        PageViewItem<Juz>(context.read<HomeCubit>().juzs),
        PageViewItem<Surah>(context.read<HomeCubit>().surahs),
      ],
    );
  }
}

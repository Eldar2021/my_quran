import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/home/logic/home_cubit.dart';
import 'package:hatim/modules/home/view/page_view_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: CupertinoColors.systemGrey2,
          thumbColor: Colors.black,
          groupValue: context.watch<HomeCubit>().state,
          onValueChanged: (v) async {
            context.read<HomeCubit>().change(v);
            await controller.animateToPage(
              context.read<HomeCubit>().state,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
          children: const <int, Widget>{
            0: PageViewCard(page: 'Juz'),
            1: PageViewCard(page: 'Surah'),
          },
        ),
      ),
      child: PageView(
        controller: controller,
        onPageChanged: context.read<HomeCubit>().change,
        children: [
          PageViewItem<Juz>(context.read<HomeCubit>().juzs),
          PageViewItem<Surah>(context.read<HomeCubit>().surahs),
        ],
      ),
    );
  }
}

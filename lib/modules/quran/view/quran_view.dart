import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, AppRouter.settingsPage);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => QuranCubit(),
        child: QuranBody(),
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
    );
  }
}

class QuranBody extends StatelessWidget {
  QuranBody({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: CupertinoColors.systemGrey2,
          thumbColor: Colors.black,
          groupValue: context.watch<QuranCubit>().state,
          onValueChanged: (v) async {
            context.read<QuranCubit>().change(v);
            await controller.animateToPage(
              context.read<QuranCubit>().state,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
          children: const <int, Widget>{
            0: PageViewCard(page: 'Juz', key: Key('juz-items')),
            1: PageViewCard(page: 'Surah', key: Key('surah-items')),
          },
        ),
      ),
      child: PageView(
        controller: controller,
        onPageChanged: context.read<QuranCubit>().change,
        children: [
          PageViewItem<Juz>(context.read<QuranCubit>().juzs),
          PageViewItem<Surah>(context.read<QuranCubit>().surahs),
        ],
      ),
    );
  }
}

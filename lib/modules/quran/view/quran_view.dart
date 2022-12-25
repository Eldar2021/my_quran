import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => QuranCubit(),
        child: const QuranBody(),
      ),
    );
  }
}

class QuranBody extends StatelessWidget {
  const QuranBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        backgroundColor: colorScheme.surfaceVariant,
        bottom: TabBar(
          indicatorColor: colorScheme.primaryContainer,
          labelColor: colorScheme.onSurface,
          tabs: const [
            PageViewCard(page: 'Juz', key: Key('juz-items')),
            PageViewCard(page: 'Surah', key: Key('surah-items')),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          PageViewItem<Juz>(context.read<QuranCubit>().juzs),
          PageViewItem<Surah>(context.read<QuranCubit>().surahs),
        ],
      ),
    );
  }
}

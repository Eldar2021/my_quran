import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';

import 'package:hatim/constants/contants.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class HatimView extends StatelessWidget {
  const HatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HatimJuzCubit()),
        BlocProvider(create: (context) => HatimReadCubit()),
      ],
      child: const HatimUI(),
    );
  }
}

class HatimUI extends StatelessWidget {
  const HatimUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('hatim-view'),
        title: Text(context.l10n.homeAppBarTitle),
        actions: [
          Text(
            '${context.watch<HatimReadCubit>().state.pages.length}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: HatimJuzListBuilder(context.watch<HatimJuzCubit>().hatimJusData),
      floatingActionButton: context.select((HatimReadCubit cubit) {
        if (cubit.state.pages.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () async {
              await Navigator.pushNamed(context, AppRouter.read, arguments: cubit.state.pages);
            },
            label: const Text('Read'),
            icon: Assets.icons.openBook.svg(),
          );
        } else {
          return null;
        }
      }),
    );
  }
}

class HatimJuzListBuilder extends StatelessWidget {
  const HatimJuzListBuilder(this.items, {super.key});

  final List<HatimJus> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              key: Key('quran-view-${item.id}-juz'),
              leading: Text('${item.id}'),
              title: Row(
                children: [
                  Text(item.name),
                  const SizedBox(width: 10),
                  Text('${item.id} - ${context.l10n.juz}'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalText(context.l10n.hatimDoneRead, '${item.donePercent}%'),
                  VerticalText(context.l10n.hatimProccessRead, '${item.processPersent}%'),
                  VerticalText(context.l10n.hatimEmptyRead, '${item.emptyPersent}%'),
                ],
              ),
              onTap: () async {
                await showDialog<void>(
                  context: context,
                  barrierLabel: '',
                  builder: (ctx) {
                    return BlocProvider(
                      create: (context) => HatimPageCubit(item.id)..getData(),
                      child: const Dialog(child: HatimSelectPageView()),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

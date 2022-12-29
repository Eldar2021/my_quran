import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/constants/contants.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class HatimView extends StatelessWidget {
  const HatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HatimView'),
        actions: [
          BlocBuilder<HatimReadCubit, HatimReadState>(
            builder: (context, state) {
              return Text(
                '${state.pages.length}',
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
          const SizedBox(width: 30)
        ],
      ),
      body: BlocProvider(
        create: (context) => HatimJuzCubit(),
        child: const HatimJuzListBuilder(),
      ),
      floatingActionButton: context.select((HatimReadCubit cubit) {
        if (cubit.state.pages.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () {
              context.read<HatimReadCubit>().setPage(5);
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
  const HatimJuzListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      itemCount: context.read<HatimJuzCubit>().hatimJusData.length,
      itemBuilder: (BuildContext context, int index) {
        final hatimJuz = context.read<HatimJuzCubit>().hatimJusData[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Text('${hatimJuz.id}'),
              title: Row(
                children: [
                  Text(hatimJuz.name),
                  const SizedBox(width: 10),
                  Text('${hatimJuz.id} - juz'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalText('Done', '${hatimJuz.donePercent}%'),
                  VerticalText('Process', '${hatimJuz.processPersent}%'),
                  VerticalText('Empty', '${hatimJuz.emptyPersent}%'),
                ],
              ),
              onTap: () async {
                await showDialog<void>(
                  context: context,
                  barrierLabel: '',
                  builder: (ctx) {
                    return BlocProvider(
                      create: (context) => HatimPageCubit(hatimJuz.id)..getData(),
                      child: const Dialog(child: HatinPageDailogBody()),
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

class HatinPageDailogBody extends StatelessWidget {
  const HatinPageDailogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Please select pages',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          BlocBuilder<HatimPageCubit, HatimPageState>(
            builder: (context, state) {
              if (state.pages != null) {
                return const HatimPageGridLisrBuilder();
              } else {
                return const Center(child: CupertinoAlertDialog());
              }
            },
          ),
          const SizedBox(height: 15),
          DoneProgcessingEmptyHint(
            color: colorScheme.primary,
            hintText: 'This is Done color',
          ),
          const SizedBox(height: 15),
          DoneProgcessingEmptyHint(
            color: colorScheme.tertiary,
            hintText: 'This is Processing color',
          ),
          const SizedBox(height: 15),
          DoneProgcessingEmptyHint(
            color: colorScheme.secondary,
            hintText: 'This is Empty color',
          ),
          const SizedBox(height: 25),
          const Text(
            'However, as the above widgets use lazy loading/viewport* the size is not determined upfront and an exception is thrown within',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  // Todo: bul jerde barakchany tandagan funksya jazylat
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DoneProgcessingEmptyHint extends StatelessWidget {
  const DoneProgcessingEmptyHint({
    super.key,
    required this.color,
    required this.hintText,
  });

  final Color color;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Material(type: MaterialType.card, color: color),
        ),
        const SizedBox(width: 14),
        Text(hintText),
      ],
    );
  }
}

class HatimPageGridLisrBuilder extends StatelessWidget {
  const HatimPageGridLisrBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: context.read<HatimPageCubit>().state.pages?.length,
        itemBuilder: (BuildContext context, int index) {
          final hatimPage = context.read<HatimPageCubit>().state.pages![index];
          return HatimPageStatusCard(hatimPage: hatimPage);
        },
      ),
    );
  }
}

class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({super.key, required this.hatimPage});

  final HatimPage hatimPage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: hatimPage.status == PageStatus.empty
          ? () {
              if (!context.read<HatimReadCubit>().state.pages.contains(hatimPage.id)) {
                context.read<HatimReadCubit>().setPage(hatimPage.id);
              } else {
                context.read<HatimReadCubit>().removePage(hatimPage.id);
              }
            }
          : null,
      child: Material(
        type: MaterialType.card,
        color: hatimPage.status == PageStatus.done
            ? colorScheme.primary
            : hatimPage.status == PageStatus.process
                ? colorScheme.tertiary
                : colorScheme.secondary,
        child: Stack(
          children: [
            Center(
              child: Text(
                '${hatimPage.id}',
                style: TextStyle(
                  color: hatimPage.status == PageStatus.done
                      ? colorScheme.onPrimary
                      : hatimPage.status == PageStatus.process
                          ? colorScheme.onTertiary
                          : colorScheme.onSecondary,
                ),
              ),
            ),
            BlocBuilder<HatimReadCubit, HatimReadState>(
              builder: (context, state) {
                return Positioned(
                  right: 2,
                  top: 2,
                  child: state.pages.contains(hatimPage.id)
                      ? Icon(Icons.check, size: 20, color: colorScheme.onPrimary)
                      : const SizedBox.shrink(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

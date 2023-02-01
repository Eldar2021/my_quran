import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class HatimView extends StatelessWidget {
  const HatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HatimJuzsCubit()),
        BlocProvider(create: (context) => HatimReadCubit(sl<HatimReadService>())),
        BlocProvider(create: (context) => HatimPagesCubit()),
      ],
      child: const HatimUI(),
    );
  }
}

class HatimUI extends StatefulWidget {
  const HatimUI({super.key});

  @override
  State<HatimUI> createState() => _HatimUIState();
}

class _HatimUIState extends State<HatimUI> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final token = context.read<AuthCubit>().state.user!.accessToken;
    final username = context.read<AuthCubit>().state.user!.username;
    await context.read<HatimReadCubit>().getHatim(token).then(
      (value) {
        if (value != null) {
          context.read<HatimJuzsCubit>().connect(value, token);
          context.read<HatimPagesCubit>().connect(username, token);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('hatim-view'),
      appBar: AppBar(
        title: Text(context.l10n.hatim),
        actions: [
          Text(
            '${context.watch<HatimPagesCubit>().state.pages != null ? context.watch<HatimPagesCubit>().state.pages!.length : '...'}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => getData(),
        child: BlocBuilder<HatimJuzsCubit, HatimJuzsState>(
          builder: (context, state) {
            if (state.erorText == null && state.hatimJuzs == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.hatimJuzs != null) {
              return HatimJuzListBuilder(state.hatimJuzs!);
            } else if (state.erorText != null) {
              return Center(child: Text(state.erorText!));
            } else {
              return const Center(child: Text('bilbeim'));
            }
          },
        ),
      ),
      floatingActionButton: context.select((HatimPagesCubit cubit) {
        if (cubit.state.pages != null && cubit.state.pages!.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () async {
              final token = context.read<AuthCubit>().state.user!.accessToken;
              final username = context.read<AuthCubit>().state.user!.username;
              context.read<HatimPagesCubit>().sendPage(username, token);
              final pages = List<int>.generate(cubit.state.pages!.length, (index) => cubit.state.pages![index]!.number)
                ..sort();
              final value = await Navigator.pushNamed<bool>(
                context,
                AppRouter.read,
                arguments: {'pages': pages, 'isHatim': true},
              );
              if (value != null && value && context.mounted) {
                context.read<HatimPagesCubit>().donePage(username, token);
              }
            },
            label: Text(context.l10n.read),
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
              key: Key('quran-view-$index-juz'),
              minLeadingWidth: 10,
              title: Text('   ${item.number}-${context.l10n.juz}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalText(context.l10n.hatimDoneRead, '${item.done}'),
                  VerticalText(context.l10n.hatimProccessRead, '${item.inProgress}'),
                  VerticalText(context.l10n.hatimEmptyRead, '${item.toDo}'),
                ],
              ),
              onTap: () async {
                final token = context.read<AuthCubit>().state.user!.accessToken;
                final hatimId = item.id;
                await showDialog<void>(
                  context: context,
                  barrierLabel: '',
                  builder: (ctx) {
                    return BlocProvider(
                      create: (context) => HatimJuzCubit(item.number)..connect(hatimId, token),
                      child: const HatimJusAlert(),
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

class HatimJusAlert extends StatelessWidget {
  const HatimJusAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      iconPadding: EdgeInsets.zero,
      backgroundColor: colorScheme.onPrimary,
      title: Text(
        context.l10n.hatimPleaseSelectPage,
        key: const Key('hatim-select-pages'),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      content: const HatimSelectPageView(),
      actions: [
        OutlinedButton(
          key: const Key('ok-button'),
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.select),
        )
      ],
    );
  }
}

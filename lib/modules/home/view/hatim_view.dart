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
        BlocProvider(create: (context) => HatimJuzCubit()),
        BlocProvider(create: (context) => HatimReadCubit(sl<HatimReadService>())),
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
          context.read<HatimJuzCubit>().connect(value, token);
          context.read<HatimReadCubit>().connect(username, token);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('hatim-view'),
        title: Text(context.l10n.hatim),
        actions: [
          Text(
            '${context.watch<HatimReadCubit>().state.pages != null ? context.watch<HatimReadCubit>().state.pages!.length : '...'}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => getData(),
        child: BlocBuilder<HatimJuzCubit, HatimJuzState>(
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
      floatingActionButton: context.select((HatimReadCubit cubit) {
        if (cubit.state.pages != null && cubit.state.pages!.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () async {
              final token = context.read<AuthCubit>().state.user!.accessToken;
              final username = context.read<AuthCubit>().state.user!.username;
              context.read<HatimReadCubit>().sendPage(username, token);
              // await Navigator.pushNamed(context, AppRouter.read, arguments: cubit.state.pages);
            },
            label: Text(context.l10n.read),
            icon: Assets.icons.openBook.svg(),
          );
        } else {
          return null;
        }
      }),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final token = context.read<AuthCubit>().state.user!.accessToken;
      //     final username = context.read<AuthCubit>().state.user!.username;
      //     context.read<HatimReadCubit>().sendPage(username, token);
      //   },
      // ),
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
                await showDialog<void>(
                  context: context,
                  barrierLabel: '',
                  builder: (ctx) {
                    return BlocProvider(
                      create: (context) => HatimPageCubit(item.number)..getData(),
                      child: AlertDialog(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        iconPadding: EdgeInsets.zero,
                        title: Text(
                          context.l10n.hatimPleaseSelectPage,
                          key: const Key('hatim-select-pages'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        content: const HatimSelectPageView(),
                        actions: [
                          OutlinedButton(
                            key: const Key('cancel-button'),
                            onPressed: () => Navigator.pop(context),
                            child: Text(context.l10n.cancel),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            key: const Key('ok-button'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(context.l10n.select),
                          )
                        ],
                      ),
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

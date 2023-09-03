import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class HatimView extends StatelessWidget {
  const HatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HatimJuzsCubit()),
        BlocProvider(create: (context) => HatimReadCubit(HatimReadService(context.read<RemoteClient>()))),
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
      key: const Key(MqKeys.hatimPage),
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
      key: const Key(MqKeys.hatimJuzsList),
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 70),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                key: Key(MqKeys.hatimJuzIndex(index)),
                contentPadding: const EdgeInsets.all(8),
                title: Text('${item.number}-${context.l10n.juz}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerticalText(context.l10n.hatimDoneRead, '${item.done}'),
                    VerticalText(context.l10n.hatimProccessRead, '${item.inProgress}'),
                    VerticalText(context.l10n.hatimEmptyRead, '${item.toDo}'),
                  ],
                ),
                onTap: ()async {
                  final token = context.read<AuthCubit>().state.user!.accessToken;
                  final hatimId = item.id;
                  await AppBottomSheet.showBottomSheet<void>(
                    context,
                    scrollKey: const Key(MqKeys.hatimSelectPageScroll),
                    initialChildSize: 0.85,
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<HatimPagesCubit>(),
                        ),
                        BlocProvider(
                          create: (context) => HatimJuzCubit(item.number)..connect(hatimId, token),
                        ),
                      ],
                      child: const HatimJusBottomSheet(),
                    ),
                  );
                },
              ),
              JuzPersentWidget(item),
            ],
          ),
        );
      },
    );
  }
}

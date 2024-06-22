import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/hatim/hatim.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HatimView extends StatelessWidget {
  const HatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HatimBloc(
        remoteClient: context.read<RemoteClient>(),
        token: context.read<AuthCubit>().state.user!.accessToken,
      )..add(const GetHatimDashBoardEvent()),
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(MqKeys.hatimPage),
      bottomNavigationBar: TextButton(
        onPressed: () {
          // final bloc = context.read<HatimBloc>();
          // // ignore: cascade_invocations
          // bloc.add(const GetHatimJuzsEvent('22e7e04a-de71-4568-a136-afcb18e88523'));
          WebSocketChannel? channel;

          channel = WebSocketChannel.connect(
            Uri.parse('wss://myquran.life/ws/?token=3d2cda9094f4753c375c49aa5e8e2fbedede2bbe'),
          );

          channel.stream.listen((e) {
            print('Test Connect: $e');
          });

          channel.sink.add(
            jsonEncode({
              'type': 'list_of_juz',
              'hatim_id': '22e7e04a-de71-4568-a136-afcb18e88523',
            }),
          );
        },
        child: const Text('send'),
      ),
      appBar: AppBar(
        title: Text(context.l10n.hatim),
        actions: [
          BlocBuilder<HatimBloc, HatimState>(
            buildWhen: (p, c) => p.userPagesState != c.userPagesState,
            builder: (context, state) {
              final subState = state.userPagesState;
              return switch (subState) {
                HatimUserPagesFetched() => Text('${subState.data.length}'),
                _ => const Text('...'),
              };
            },
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HatimBloc>().add(const GetHatimDashBoardEvent());
        },
        child: BlocConsumer<HatimBloc, HatimState>(
          listener: (BuildContext context, HatimState state) {
            final dashBoadrState = state.dashBoardState;
            final eventState = state.eventState;
            final juzsState = state.juzsState;
            final bloc = context.read<HatimBloc>();
            if (dashBoadrState is HatimDashBoardFetched && eventState is HatimStateInitial) {
              bloc.add(ConnectToHatimdEvent(dashBoadrState.data.id));
            }
            if (eventState is HatimStateSuccess && juzsState is HatimJuzsInitial) {
              bloc.add(GetHatimJuzsEvent(eventState.hatimId));
              // ..add(const GetHatimUserPagesEvent());
            }
          },
          builder: (context, state) {
            final juzsState = state.juzsState;
            return switch (juzsState) {
              HatimJuzsInitial() => const Center(child: CircularProgressIndicator()),
              HatimJuzsLoading() => const Center(child: CircularProgressIndicator()),
              HatimJuzsFetched() => HatimJuzListBuilder(juzsState.data),
              HatimJuzsFailed() => Center(child: Text('${juzsState.exception}')),
            };
          },
        ),
      ),
      floatingActionButton: BlocBuilder<HatimBloc, HatimState>(
        builder: (context, state) {
          final userPagesState = state.userPagesState;
          if (userPagesState is HatimUserPagesFetched) {
            final pages = userPagesState.data;
            if (pages.isNotEmpty) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final pageIds = pages.map((e) => e.id).toList();
                  final pageNumbers = pages.map((e) => e.number).toList();
                  context.read<HatimBloc>().add(SetInProgressPagesEvent(pageIds));
                  final value = await context.pushNamed<bool>(
                    AppRouter.hatimRead,
                    pathParameters: {
                      'pages': pageNumbers.toString(),
                      'isHatim': true.toString(),
                    },
                  );
                  if (value != null && value && context.mounted) {
                    context.read<HatimBloc>().add(SetDonePagesEvent(pageIds));
                  }
                },
                label: Text(context.l10n.read),
                icon: Assets.icons.openBook.svg(),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
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
                onTap: () async {
                  final bloc = context.read<HatimBloc>();
                  await AppBottomSheet.showBottomSheet<void>(
                    context,
                    scrollKey: const Key(MqKeys.hatimSelectPageScroll),
                    initialChildSize: 0.85,
                    BlocProvider.value(
                      value: bloc..add(GetHatimJuzPagesEvent(item.id)),
                      child: const HatimJusBottomSheet(),
                    ),
                  );

                  bloc.add(const ResetJuzPagesEvent());
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

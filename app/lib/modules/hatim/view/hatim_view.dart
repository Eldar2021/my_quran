import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HatimView extends StatelessWidget {
  const HatimView(this.hatimId, {super.key});

  final String hatimId;

  @override
  Widget build(BuildContext context) {
    final isMockData = context.read<AppConfig>().isMockData;
    return BlocProvider(
      create: (context) => HatimBloc(
        hatimId: hatimId,
        socket: isMockData ? MqHatimSocketMock() : MqHatimSocketImpl(),
        token: context.read<AuthCubit>().state.user!.accessToken,
      )..add(const GetInitialDataEvent()),
      child: const HatimUI(),
    );
  }
}

class HatimUI extends StatefulWidget {
  const HatimUI({super.key});

  @override
  State<HatimUI> createState() => _HatimUIState();
}

class _HatimUIState extends State<HatimUI>
    with WidgetsBindingObserver, AppLifeCycleStateMixin, InternetConnectionMixin {
  @override
  void initState() {
    super.initState();
    initAppLifeCycle();
    initConnection();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      key: const Key(MqKeys.hatimPage),
      appBar: AppBar(
        title: Text(context.l10n.hatim),
        centerTitle: true,
        actions: [
          const HatimConnectionStateWidget(),
          const SizedBox(width: 10),
          BlocBuilder<HatimBloc, HatimState>(
            buildWhen: (p, c) => p.userPagesState != c.userPagesState,
            builder: (context, state) {
              final subState = state.userPagesState;
              return switch (subState) {
                HatimUserPagesFetched() => Text(
                  '${subState.data.length}',
                  style: prTextTheme.titleLarge,
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HatimBloc>().add(const GetInitialDataEvent());
        },
        child: BlocBuilder<HatimBloc, HatimState>(
          builder: (context, state) {
            final juzsState = state.juzsState;
            return switch (juzsState) {
              HatimJuzsInitial() => const Center(
                child: CircularProgressIndicator(),
              ),
              HatimJuzsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              HatimJuzsFetched() => HatimJuzListBuilder(juzsState.data),
              HatimJuzsFailed() => Center(
                child: Text('${juzsState.exception}'),
              ),
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
                extendedTextStyle: prTextTheme.titleMedium,
                foregroundColor: colorScheme.primary,
                backgroundColor: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                  side: BorderSide(color: colorScheme.primary),
                ),
                onPressed: () async {
                  final hatimId = context.read<HatimBloc>().hatimId;
                  final pageIds = pages.map((e) => e.id).toList();
                  final pageNumbers = pages.map((e) => e.number).toList();
                  context.read<HatimBloc>().add(
                    SetInProgressPagesEvent(pageIds),
                  );
                  MqAnalytic.track(
                    AnalyticKey.goHatimReadPage,
                    params: {'pages': pageIds},
                  );
                  final value = await context.pushNamed<bool>(
                    AppRouter.hatimRead,
                    pathParameters: {
                      'hatimId': hatimId,
                      'pages': pageNumbers.toString(),
                    },
                  );
                  if (value != null && value && context.mounted) {
                    context.read<HatimBloc>().add(SetDonePagesEvent(pageIds));
                  }
                },
                label: Text(context.l10n.read),
                icon: Assets.icons.book.svg(
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void Function()? get onAppLifeCycleResumed => () {
    log('Reconnecting to socket');
  };

  @override
  void Function()? get onAppLifeCyclePaused => () {
    log('Disconnecting from socket');
  };

  @override
  void Function()? get onAppLifeCycleInactive => () {
    log('Disconnecting from socket');
  };

  @override
  void Function()? get onConnectedInternet => () {
    log('Reconnecting to socket');
  };

  @override
  void Function()? get onDisconnectedInternet => () {
    log('Disconnecting from socket');
  };

  @override
  void dispose() {
    disposeAppLifeCycle();
    disposeConnection();
    super.dispose();
  }
}

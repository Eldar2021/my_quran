import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HatimView extends StatelessWidget {
  const HatimView(this.hatimId, {super.key});

  final String hatimId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HatimBloc(
        hatimId: hatimId,
        repo: MqHatimReadRepositoryImpl(
          dataSource: context.read<AppConfig>().isMockData
              ? MqHatimRemoteDataSourceMock()
              : MqHatimRemoteDataSourceImpl(
                  remoteClient: context.read<MqRemoteClient>(),
                ),
        ),
        token: context.read<AuthCubit>().state.user!.accessToken,
      )..add(const GetInitailDataEvent()),
      child: const HatimUI(),
    );
  }
}

class HatimUI extends StatefulWidget {
  const HatimUI({super.key});

  @override
  State<HatimUI> createState() => _HatimUIState();
}

class _HatimUIState extends State<HatimUI> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<HatimBloc>().add(const ConnectWebSocketEvent());
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      context.read<HatimBloc>().add(const DisconnectWebSocketEvent());
    }
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
          const SizedBox(width: 8),
          BlocBuilder<HatimBloc, HatimState>(
            buildWhen: (p, c) => p.connectionState != c.connectionState,
            builder: (context, state) {
              final connectionState = state.connectionState;
              if (connectionState is Connected) {
                return const Icon(Icons.wifi, color: Colors.green);
              } else if (connectionState is Connecting || connectionState is Reconnecting) {
                return const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              } else {
                return const Icon(Icons.wifi_off, color: Colors.red);
              }
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HatimBloc>().add(const GetInitailDataEvent());
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
                  context.read<HatimBloc>().add(const DisconnectWebSocketEvent());
                  final value = await context.pushNamed<bool>(
                    AppRouter.hatimRead,
                    pathParameters: {
                      'hatimId': hatimId,
                      'pages': pageNumbers.toString(),
                    },
                  );
                  if (context.mounted) {
                    context.read<HatimBloc>().add(const ConnectWebSocketEvent());
                    if (value != null && value) {
                      context.read<HatimBloc>().add(SetDonePagesEvent(pageIds));
                    }
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
}

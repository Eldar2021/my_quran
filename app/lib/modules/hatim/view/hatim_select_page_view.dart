import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/config/router/app_router.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/hatim/hatim.dart';
import 'package:my_quran/modules/modules.dart';

class HatimJusSelectPagesView extends StatelessWidget {
  const HatimJusSelectPagesView({
    required this.hatimJusEntity,
    super.key,
  });

  final MqHatimJusEntity hatimJusEntity;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      key: const Key(MqKeys.hatimSelectPage),
      appBar: AppBar(
        actions: const [
          HatimConnectionStateWidget(),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
        children: [
          Center(
            child: Text(
              context.l10n.hatim,
              style: prTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                context.l10n.selectBelowPages,
                style: prTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          MqHalfCircleChart(
            annotation: '${hatimJusEntity.total}\n${context.l10n.totalPages}',
            dataSource: [
              hatimJusEntity.done,
              hatimJusEntity.inProgress,
              hatimJusEntity.toDo,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColumnInfoColoredBox.circular(
                title: context.l10n.readed,
                value: '${hatimJusEntity.done}',
              ),
              ColumnInfoColoredBox.circular(
                boxColor: AppColors.goldenrod,
                title: context.l10n.reading,
                value: '${hatimJusEntity.inProgress}',
              ),
              ColumnInfoColoredBox.circular(
                boxColor: AppColors.mediumseagreen,
                title: context.l10n.notSelected,
                value: '${hatimJusEntity.toDo}',
              ),
            ],
          ),
          const SizedBox(height: 25),
          BlocBuilder<HatimBloc, HatimState>(
            builder: (context, state) {
              final juzPagesState = state.juzPagesState;
              return switch (juzPagesState) {
                HatimJuzPagesInitial() => const Center(
                  child: CircularProgressIndicator(),
                ),
                HatimJuzPagesLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                HatimJuzPagesFetched() => HatimPageGridListBuilder(
                  juzPagesState.data,
                ),
                HatimJuzPagesFailed() => Center(
                  child: Text('${juzPagesState.exception}'),
                ),
              };
            },
          ),
          const SizedBox(height: 30),
          BlocBuilder<HatimBloc, HatimState>(
            builder: (context, state) {
              final userPagesState = state.userPagesState;
              if (userPagesState is HatimUserPagesFetched) {
                final pages = userPagesState.data;
                if (pages.isNotEmpty) {
                  return ElevatedButton(
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
                        context.read<HatimBloc>().add(
                          SetDonePagesEvent(pageIds),
                        );
                      }
                    },
                    child: Text(context.l10n.read),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: AppSpacing.bottomSpace),
        ],
      ),
    );
  }
}

class HatimPageGridListBuilder extends StatelessWidget {
  const HatimPageGridListBuilder(this.items, {super.key});

  final List<MqHatimPagesEntity> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: items.map((e) {
        return HatimPageStatusCard(
          status: e.status,
          pageNumber: e.number,
          isMine: e.mine,
          onTap: e.status.isActive
              ? () {
                  final bloc = context.read<HatimBloc>();
                  if (e.status == HatimPageStatus.todo) {
                    MqAnalytic.track(
                      AnalyticKey.selectPage,
                      params: {'page': e.id},
                    );
                    bloc.add(SelectPageEvent(e.id));
                  } else if (e.mine) {
                    MqAnalytic.track(
                      AnalyticKey.unselectPage,
                      params: {'page': e.id},
                    );
                    bloc.add(UnSelectPageEvent(e.id));
                  }
                }
              : null,
        );
      }).toList(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with NotificationMixin {
  @override
  void initState() {
    super.initState();
    _getHomeData();
    final auth = context.read<AuthCubit>().state.auth;
    final validName = auth?.user.username?.replaceAll(RegExp(r'\W+'), '_');
    if (auth != null) {
      MqCrashlytics.setUserIdentifier(validName ?? auth.key);
      MqAnalytic.setUserProperty(validName ?? auth.key);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initializeNotification(auth, context);
      });
    }
    context.read<LocationCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.homeView),
        title: Text(context.l10n.hello),
        centerTitle: true,
        actions: const [
          NotificationCountBadgeWidget(),
          SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          MqAnalytic.track(AnalyticKey.refreshHomePage);
          await _getHomeData();
        },
        child: ListView(
          key: const Key(MqKeys.homeListView),
          children: [
            const SizedBox(height: 10),
            BlocBuilder<MqStoryCubit, MqStoryState>(
              builder: (context, state) {
                final status = state.status;
                return switch (status) {
                  FetchStatus.initial || FetchStatus.loading || FetchStatus.error => const SizedBox.shrink(),
                  FetchStatus.success => MqStoryItemsWidget(
                    listHeight: 132,
                    buttonWidth: 70,
                    buttonSpacing: 14,
                    items: state.getStories.asMap().entries.map((e) {
                      final idIndex = e.key;
                      final item = e.value;
                      return MqStoryItem(
                        id: '$idIndex',
                        cardImageLink: item.cardImageUrl,
                        cardLabel: item.cardLabel,
                        storyPagesImages: item.screens.map((e) => e.imageUrl).toList(),
                        storyPageDuration: List.generate(
                          item.screens.length,
                          (index) => Duration(
                            milliseconds: item.screens[index].durationByMilliseconds,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                };
              },
            ),
            const SizedBox(height: 8),
            const MqSalaahTimeWidget(),
            const SizedBox(height: 10),
            Builder(
              builder: (ctx) {
                return ListTile(
                  onTap: () => AppShare.shareUri(
                    context: ctx,
                    url: ApiConst.oneLink,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  leading: CircleAvatar(
                    backgroundColor: colorScheme.onInverseSurface,
                    child: Assets.icons.shareFill.svg(
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  title: Text(
                    context.l10n.shareApp,
                    style: prTextTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
            const SizedBox(height: 10),
            const HomeBannerWidget(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.progress,
                    style: prTextTheme.titleMedium,
                  ),
                  Text(
                    context.l10n.joinChallenge,
                    style: prTextTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return MyQuranStaticsInfoWidget(
                    label1: context.l10n.totalHatims,
                    label2: context.l10n.totalPages,
                    label3: context.l10n.yourPages,
                    count1: '${state.homeModel?.allDoneHatims ?? 0}',
                    count2: '${state.homeModel?.allDonePages ?? 0}',
                    count3: '${state.homeModel?.donePages ?? 0}',
                  );
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final hatims = state.homeModel?.hatims;
            return ElevatedButton(
              key: const Key(MqKeys.participantToHatim),
              onPressed: () {
                final isIntegrationTest = context.read<AppConfig>().isIntegrationTest;
                if ((hatims?.length ?? 0) > 1 && !isIntegrationTest) {
                  ShowHatimWidget.showHatimSheet<void>(
                    context: context,
                    hatim: hatims!,
                  );
                } else {
                  _onJoinToHatim(hatims ?? []);
                }
              },
              child: Text(context.l10n.joinToHatim),
            );
          },
        ),
      ),
    );
  }

  void _onJoinToHatim(List<MqHatimsModel> hatims) {
    final hatimId = hatims.isNotEmpty ? hatims.first.id : null;
    if (hatimId != null) {
      MqAnalytic.track(AnalyticKey.goHatim);
      context.goNamedIfAuthenticated(
        AppRouter.hatim,
        pathParameters: {'hatimId': hatimId},
      );
    } else {
      context.pushNamed(AppRouter.loginWihtSoccial);
    }
  }

  Future<void> _getHomeData() async {
    final homeCubit = context.read<HomeCubit>();
    final storyCubit = context.read<MqStoryCubit>();
    final authCubit = context.read<AuthCubit>();
    final bannerCubit = context.read<HomeBannersCubit>();
    final isIntegrationTest = context.read<AppConfig>().isIntegrationTest;

    if (authCubit.state.auth != null) {
      unawaited(context.read<ProfileCubit>().getUserData(authCubit.state.auth!.key));
    }

    await Future.wait([
      homeCubit.getData(),
      storyCubit.getStories(authCubit.state.currentLocale.languageCode),
      bannerCubit.getBanners(),
    ]);

    final invites = homeCubit.state.homeModel?.invitedHatims;

    if (invites != null && invites.isNotEmpty && !isIntegrationTest) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        await ShowInvitationWidget.showInvitationSheet<void>(
          context: context,
          invitedHatims: homeCubit.state.homeModel!.invitedHatims!,
        );
        await homeCubit.getData();
      });
    }
  }
}

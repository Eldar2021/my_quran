import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/utils/show/snackbars.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getHomeData();
    final user = context.read<AuthCubit>().state.user;
    final validName = user?.username.replaceAll(RegExp(r'\W+'), '_');
    if (user != null) {
      MqCrashlytics.setUserIdentifier(validName ?? user.accessToken);
      MqAnalytic.setUserProperty(validName ?? user.accessToken);
    }
    context.read<LocationCubit>().fetchLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(
        closeDrawer: () {
          _scaffoldKey.currentState?.closeDrawer();
        },
      ),
      appBar: AppBar(
        key: const Key(MqKeys.homeView),
        title: Text(context.l10n.hello),
        centerTitle: true,
        leading: IconButton(
          key: const Key(MqKeys.settings),
          padding: const EdgeInsets.only(left: 24),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Assets.icons.settingsBurger.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 24),
            onPressed: () {
              AppSnackbar.showSnackbar(
                context,
                context.l10n.featureInFuture,
              );
            },
            icon: Assets.icons.qyblaDirection.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
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
            const SizedBox(height: 20),
            BlocBuilder<MqStoryCubit, MqStoryState>(
              builder: (context, state) {
                final status = state.status;
                return switch (status) {
                  FetchStatus.loading || FetchStatus.error => const SizedBox.shrink(),
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
                            (index) => Duration(milliseconds: item.screens[index].durationByMilliseconds),
                          ),
                        );
                      }).toList(),
                    )
                };
              },
            ),
            const SizedBox(height: 20),
            const MqSalaahTimeWidget(),
            const SizedBox(height: 20),
            ListTile(
              onTap: () => AppShare.shareUri(ApiConst.oneLink),
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
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                builder: (context, state) {
                  return ElevatedButton(
                    key: const Key(MqKeys.participantToHatim),
                    onPressed: state.isHatimEnable ? _onJoinToHatim : null,
                    child: Text(context.l10n.joinToHatim),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _onJoinToHatim() {
    MqAnalytic.track(AnalyticKey.goHatim);
    context.goNamedIfAuthenticated(AppRouter.hatim);
  }

  Future<void> _getHomeData() async {
    final homeCubit = context.read<HomeCubit>();
    final storyCubit = context.read<MqStoryCubit>();
    final authCubit = context.read<AuthCubit>();
    await Future.wait([
      homeCubit.getData(),
      storyCubit.getStories(authCubit.state.currentLocale.languageCode),
    ]);
  }
}

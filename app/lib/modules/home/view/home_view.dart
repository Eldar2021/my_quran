import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

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
    _initTrackingAndServices();
    context.read<LocationCubit>().init();
  }

  void _initTrackingAndServices() {
    final auth = context.read<AuthCubit>().state.auth;
    final validName = auth?.user.username?.replaceAll(RegExp(r'\W+'), '_');
    if (auth != null) {
      MqCrashlytics.setUserIdentifier(validName ?? auth.key);
      MqAnalytic.setUserProperty(validName ?? auth.key);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initializeNotification(auth, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
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
            const HomeStoriesWidget(),
            const MqSalaahTimeWidget(),
            const SizedBox(height: 10),
            const HomeShareTile(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: UserActivityCard(),
            ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: HomeStaticsWidget(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: HomeFabWidget(),
      ),
    );
  }

  Future<void> _getHomeData() async {
    final homeCubit = context.read<HomeCubit>();
    final storyCubit = context.read<MqStoryCubit>();
    final authCubit = context.read<AuthCubit>();
    final isIntegrationTest = context.read<AppConfig>().isIntegrationTest;

    if (authCubit.state.auth != null) {
      unawaited(context.read<ProfileCubit>().getUserData(authCubit.state.auth!.key));
      unawaited(context.read<UserActivityCubit>().loadActivities(authCubit.state.auth!.key));
    } else {
      context.read<UserActivityCubit>().setUnauthorized();
    }

    await Future.wait([
      homeCubit.getData(),
      storyCubit.getStories(authCubit.state.currentLocale.languageCode),
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

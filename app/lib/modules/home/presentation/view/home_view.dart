import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/config/config.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final homeCubit = context.read<HomeCubit>();
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;
    final validName = user?.username.replaceAll(RegExp(r'\W+'), '_');
    if (homeCubit.state.status != FetchStatus.success && user != null) {
      MqCrashlytics.setUserIdentifier(validName ?? user.accessToken);
      MqAnalytic.setUserProperty(validName ?? user.accessToken);
      homeCubit.getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final homeCubit = context.watch<HomeCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          MqAnalytic.track(AnalyticKey.refreshHomePage);
          await context.read<HomeCubit>().getData();
        },
        child: SafeArea(
          child: ListView(
            key: const Key(MqKeys.homeListView),
            children: [
              const SizedBox(height: 10),
              Assets.icons.alQuran.svg(
                key: const Key(MqKeys.alQuran),
                height: 100,
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              ),
              HomeCard(
                key: const Key(MqKeys.allHatimCount),
                titleText: l10n.homeAllHatim,
                descriptioText: l10n.homeAllHatimDesc,
                valueText: '${homeCubit.state.homeModel?.allDoneHatims ?? 0}',
              ),
              HomeCard(
                key: const Key(MqKeys.allReadedPageCount),
                titleText: l10n.allDonePages,
                descriptioText: l10n.allDonePagesDesc,
                valueText: '${homeCubit.state.homeModel?.allDonePages ?? 0}',
                verticalSpace: 0,
              ),
              HomeCard(
                titleText: l10n.homeUserReadAllPage,
                descriptioText: l10n.homeUserReadAllPageDesc,
                valueText: '${homeCubit.state.homeModel?.donePages ?? 0}',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                  builder: (context, state) {
                    return CustomButton(
                      key: const Key(MqKeys.participantToHatim),
                      text: l10n.homeGoHatim,
                      onPressed: state.isHatimEnable ? _onJoinToHatim : null,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onJoinToHatim() {
    MqAnalytic.track(AnalyticKey.goHatim);
    context.goNamed(AppRouter.hatim);
  }
}

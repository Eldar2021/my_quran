import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider.of<AppConfig>(context).isIntegrationTest
          ? const _HomeBody()
          : UpgradeAlert(
              upgrader: Upgrader(
                shouldPopScope: () => true,
                canDismissDialog: true,
              ),
              child: const _HomeBody(),
            ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final homeCubit = context.watch<HomeCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () async {
        if (context.read<AuthCubit>().state.user != null) {
          await context.read<HomeCubit>().getData(context.read<AuthCubit>().state.user!.accessToken);
        }
      },
      child: SafeArea(
        child: ListView(
          key: const Key('home-list-view'),
          children: [
            const SizedBox(height: 10),
            Assets.icons.alQuran.svg(
              key: const Key('al-quran'),
              height: 100,
              colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
            ),
            HomeCard(
              titleText: l10n.homeAllHatim,
              descriptioText: l10n.homeAllHatimDesc,
              valueText: '${homeCubit.state.homeModel?.allDoneHatims ?? 0}',
            ),
            HomeCard(
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
              child: CustomButton(
                key: const Key('home-view-button'),
                text: l10n.homeGoHatim,
                onPressed: () async {
                  await Navigator.pushNamed(context, AppRouter.hatim);
                  if (context.mounted) {
                    await context.read<HomeCubit>().getData(context.read<AuthCubit>().state.user!.accessToken);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

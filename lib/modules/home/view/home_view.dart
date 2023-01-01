import 'package:flutter/material.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/components/components.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/modules/modules.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          key: const Key('home-list-view'),
          children: [
            const SizedBox(height: 10),
            Assets.icons.alQuran.svg(
              key: const Key('al-quran'),
              height: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            HomeCard(
              titleText: l10n.homeAllHatim,
              descriptioText: l10n.homeAllHatimDesc,
              valueText: '147',
            ),
            HomeCard(
              titleText: l10n.homeUserReadAllPage,
              descriptioText: l10n.homeUserReadAllPageDesc,
              valueText: '1647',
              verticalSpace: 0,
            ),
            const TimeCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                key: const Key('home-view-button'),
                text: l10n.homeGoHatim,
                onPressed: () async {
                  await Navigator.pushNamed(context, AppRouter.hatim);
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

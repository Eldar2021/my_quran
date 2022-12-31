import 'package:flutter/material.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/components/components.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/modules/modules.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Assets.icons.alQuran.svg(key: const Key('al-quran'), height: 100, color: Theme.of(context).colorScheme.primary),
            const HomeCard(
              titleText: 'Jalpy Okulgan Hatim',
              descriptioText:
                  'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
              valueText: '147',
            ),
            const HomeCard(
              titleText: 'Siz Okugan Barak sany',
              descriptioText:
                  'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
              valueText: '1647',
              verticalSpace: 0,
            ),
            const TimeCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                key: const Key('home-view-button'),
                text: 'Hatimga Katysh ->',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/components/components.dart';
import 'package:intl/intl.dart';

import 'package:hatim/constants/contants.dart';
import 'package:hatim/modules/modules.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TimeCubit()..change(),
          child: const HomeBody(),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        Assets.icons.alQuran.svg(height: 100),
        const HomeCard(
          titleText: 'Jalpy Okulgan Hatim',
          descriptioText:
              'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
          valueText: '147',
          // verticalSpace: 0,
        ),
        const HomeCard(
          titleText: 'Siz Okugan Barak sany',
          descriptioText:
              'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
          valueText: '1647',
          verticalSpace: 0,
        ),
        HomeCard(
          titleText: DateFormat('dd/MM/yyy').format(context.watch<TimeCubit>().state),
          descriptioText:
              'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
          valueText: DateFormat('mm:ss').format(context.watch<TimeCubit>().state),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomButton(
            text: 'Hatimga Katysh ->',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

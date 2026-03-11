import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeStaticsWidget extends StatelessWidget {
  const HomeStaticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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
    );
  }
}

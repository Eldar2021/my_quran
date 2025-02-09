import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSliverAmenButton extends StatelessWidget {
  const QuranBookSliverAmenButton({
    required this.onAmenPressed,
    required this.afterAmenPressed,
    super.key,
  });

  final void Function() onAmenPressed;
  final void Function() afterAmenPressed;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 50,
          left: 24,
          right: 24,
        ),
        child: ElevatedButton(
          onPressed: () async {
            MqAnalytic.track(AnalyticKey.showAmin);
            await MqAlertDialogs.showAmen<void>(
              context: context,
              backgroundColor: themeCubit.state.bgColor,
              foregroundColor: themeCubit.state.frColor,
              title: context.l10n.amen,
              content: context.l10n.dua,
              buttonText: context.l10n.ameen,
              gender: context.read<AuthCubit>().state.mqAppUiGender,
              onPressed: onAmenPressed,
            );

            afterAmenPressed();
          },
          child: Text(context.l10n.readed),
        ),
      ),
    );
  }
}

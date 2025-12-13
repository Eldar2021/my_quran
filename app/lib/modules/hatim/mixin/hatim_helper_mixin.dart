import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/config/router/app_router.dart';
import 'package:my_quran/modules/modules.dart';

mixin HatimHelperMixin {
  Future<void> navigateToHatimRead(
    List<MqHatimPagesEntity> pages,
    BuildContext context,
  ) async {
    final hatimId = context.read<HatimBloc>().hatimId;
    final pageIds = pages.map((e) => e.id).toList();
    final pageNumbers = pages.map((e) => e.number).toList();

    context.read<HatimBloc>().add(SetInProgressPagesEvent(pageIds));

    MqAnalytic.track(
      AnalyticKey.goHatimReadPage,
      params: {'pages': pageIds},
    );

    final value = await context.pushNamed<bool>(
      AppRouter.hatimRead,
      pathParameters: {
        'hatimId': hatimId,
        'pages': pageNumbers.toString(),
      },
    );
    if (value != null && value && context.mounted) {
      context.read<HatimBloc>().add(SetDonePagesEvent(pageIds));
    }
  }
}

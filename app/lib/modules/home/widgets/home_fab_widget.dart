import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeFabWidget extends StatelessWidget {
  const HomeFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final hatims = state.homeModel?.hatims;
        if (hatims?.isEmpty ?? true) return const SizedBox.shrink();
        return ElevatedButton(
          key: const Key(MqKeys.participantToHatim),
          onPressed: () {
            final isIntegrationTest = context.read<AppConfig>().isIntegrationTest;
            if ((hatims?.length ?? 0) > 1 && !isIntegrationTest) {
              ShowHatimWidget.showHatimSheet<void>(
                context: context,
                hatim: hatims!,
              );
            } else {
              _onJoinToHatim(context, hatims ?? []);
            }
          },
          child: Text(context.l10n.joinToHatim),
        );
      },
    );
  }

  void _onJoinToHatim(BuildContext context, List<MqHatimsModel> hatims) {
    final hatim = hatims.isNotEmpty ? hatims.first : null;
    final user = context.read<AuthCubit>().state.auth;
    if (hatim != null) {
      MqAnalytic.track(AnalyticKey.goHatim);
      context.goNamedIfAuthenticated(
        AppRouter.hatim,
        pathParameters: {'hatimId': hatim.id},
        extra: hatim.isCreator(user?.user.username ?? ''),
      );
    } else {
      context.pushNamed(AppRouter.loginWihtSoccial);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';

class MyQuranAppVersionTile extends StatelessWidget {
  const MyQuranAppVersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
      builder: (context, state) {
        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: colors.surface,
          child: DrawerTile(
            title: '${ApiConst.appName} ${state.version}(${state.buildNumber})',
            icon: CircleAvatar(
              backgroundImage: Assets.images.appIcon.provider(),
            ),
            trailing: const SizedBox.shrink(),
            onLongPress: () => context.pushNamed(AppRouter.devModeView),
          ),
        );
      },
    );
  }
}

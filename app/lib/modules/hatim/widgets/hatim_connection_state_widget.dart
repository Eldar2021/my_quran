import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/modules/modules.dart';

class HatimConnectionStateWidget extends StatelessWidget implements PreferredSizeWidget {
  const HatimConnectionStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HatimConnectionCubit, HatimConnectionState>(
      builder: (context, state) {
        final appLifecycleStateType = state.appLifecycleStateType;
        final internetStateType = state.internetStateType;
        return Row(
          children: [
            if (appLifecycleStateType == HatimAppLifecycleStateType.paused)
              const ColoredBox(
                color: AppColors.dartRed,
                child: SizedBox(width: 8, height: 4),
              ),
            Expanded(
              child: _ConnectionProgressWidget(state.stateType),
            ),
            if (internetStateType == HatimInternetStateType.disconnected)
              const ColoredBox(
                color: AppColors.dartRed,
                child: SizedBox(width: 8, height: 4),
              ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(5);
}

class _ConnectionProgressWidget extends StatelessWidget {
  const _ConnectionProgressWidget(this.type);

  final HatimConnectionStateType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      HatimConnectionStateType.connecting => const LinearProgressIndicator(
        color: AppColors.gold,
      ),
      HatimConnectionStateType.connected => LinearProgressIndicator(
        value: 1,
        color: Theme.of(context).colorScheme.surface,
      ),
      HatimConnectionStateType.reconnecting => const LinearProgressIndicator(
        color: AppColors.yellow,
      ),
      HatimConnectionStateType.reconnected => LinearProgressIndicator(
        value: 1,
        color: Theme.of(context).colorScheme.surface,
      ),
      HatimConnectionStateType.disconnecting => const LinearProgressIndicator(
        color: AppColors.red,
      ),
      HatimConnectionStateType.disconnected => const LinearProgressIndicator(
        value: 1,
        color: AppColors.red,
      ),
    };
  }
}

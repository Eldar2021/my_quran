import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/modules/modules.dart';

class HatimConnectionStateWidget extends StatelessWidget {
  const HatimConnectionStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return BlocBuilder<HatimBloc, HatimState>(
      buildWhen: (p, c) => p.connectionState != c.connectionState,
      builder: (context, state) {
        final connectionState = state.connectionState;
        final iconColor = switch (connectionState) {
          Connecting() => Colors.yellow,
          Connected() => Colors.green,
          Reconnecting() => Colors.orange,
          Reconnected() => Colors.green,
          Disconnecting() => Colors.redAccent,
          Disconnected() => Colors.red,
        };
        final label = switch (connectionState) {
          Connecting() => 'connecting',
          Connected() => 'connected',
          Reconnecting() => 'reconnecting',
          Reconnected() => 'reconnected',
          Disconnecting() => 'disconnecting',
          Disconnected() => 'disconnected',
        };
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi,
              color: iconColor,
            ),
            Text(
              label,
              style: prTextTheme.labelMedium,
            ),
          ],
        );
      },
    );
  }
}

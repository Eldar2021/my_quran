import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class ToggleNotification extends StatelessWidget {
  const ToggleNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.notifications,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: DrawerTile(
            title: context.l10n.notifications,
            icon: Icon(
              Icons.notifications_none_outlined,
              color: colorScheme.primary,
            ),
            trailing: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (context, state) {
                final allowedState = state.allowedState;
                if (allowedState is NotificationAllowedError) {
                  _onError(allowedState.error, context);
                }
              },
              builder: (context, state) {
                final allowedState = state.allowedState;
                return switch (allowedState) {
                  NotificationAllowedLoading() => const CupertinoActivityIndicator(),
                  NotificationAllowedInitial() => Switch(
                    value: false,
                    onChanged: (_) {},
                  ),
                  _ => Switch(
                    value: allowedState.value,
                    onChanged: (value) => _toggleNotification(context, value),
                  ),
                };
              },
            ),
          ),
        ),
      ],
    );
  }

  void _toggleNotification(BuildContext context, bool value) {
    context.read<NotificationCubit>().toggleNotification(
      context.read<AuthCubit>().userId,
      value,
    );
  }

  void _onError(Object error, BuildContext context) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
  }
}

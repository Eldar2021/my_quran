import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

class NotificationCountBadgeWidget extends StatefulWidget {
  const NotificationCountBadgeWidget({super.key});

  @override
  State<NotificationCountBadgeWidget> createState() => _NotificationCountBadgeWidgetState();
}

class _NotificationCountBadgeWidgetState extends State<NotificationCountBadgeWidget> {
  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthCubit>().state.auth?.key;
    context.read<NotificationCubit>().getNotificationCount(userId);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (p, c) => p.countState != c.countState,
      builder: (context, state) {
        final count = state.countState.count;
        return Badge.count(
          offset: const Offset(0, 10),
          count: count,
          isLabelVisible: count > 0,
          child: IconButton(
            onPressed: () {
              context.pushNamed(AppRouter.notification);
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: colorScheme.onSurface,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}

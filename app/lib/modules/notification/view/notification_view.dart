import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    context.read<NotificationCubit>().getNotification(user?.localeCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.notifications),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationCubit, NotificationGlobalState>(
        builder: (context, state) {
          final fetchState = state.fetchState;
          if (fetchState is NotificationInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (fetchState is NotificationSuccess) {
            final notifications = fetchState.notifications;
            if (notifications == null || notifications.isEmpty) {
              return Center(
                child: Text(
                  context.l10n.empty,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            return ListView.separated(
              itemCount: notifications.length,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];
                return NotificationItem(
                  title: item.title,
                  body: item.body,
                );
              },
            );
          } else {
            return Center(
              child: Text(context.l10n.empty),
            );
          }
        },
      ),
    );
  }
}

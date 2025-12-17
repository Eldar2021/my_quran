import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
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
    final auth = context.read<AuthCubit>().state.auth;
    context.read<NotificationCubit>().getNotification(
      auth?.user.language ?? 'en',
      auth?.key ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onDoubleTap: _showDialog,
          child: Text(context.l10n.notifications),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NotificationSuccess) {
            final notifications = state.notifications;
            if (notifications == null || notifications.isEmpty) {
              return const NotificationEmptyState();
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
            return const NotificationEmptyState();
          }
        },
      ),
    );
  }

  void _showDialog() {
    final fcmToken = context.read<AuthRepository>().getNotificationToken();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('FCM Token'),
        content: Text(fcmToken ?? 'Empty'),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: fcmToken ?? 'Empty'));
              Navigator.pop(context);
            },
            child: const Text('Copy'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({
    required this.notifications,
    super.key,
  });

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) return const NotificationEmptyState();
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
  }
}

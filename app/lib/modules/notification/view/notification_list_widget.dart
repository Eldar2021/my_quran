import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class NotificationListWidget extends StatefulWidget {
  const NotificationListWidget({
    required this.notifications,
    super.key,
  });

  final List<NotificationModel> notifications;

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.notifications.isEmpty) return const NotificationEmptyState();
    return ListView.separated(
      reverse: true,
      itemCount: widget.notifications.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      separatorBuilder: (context, index) => const SizedBox(height: 36),
      itemBuilder: (context, index) {
        return NotificationItemWidget(widget.notifications[index]);
      },
    );
  }
}

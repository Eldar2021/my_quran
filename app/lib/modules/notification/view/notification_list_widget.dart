import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
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
        final item = widget.notifications[index];
        return NotificationItemEx(
          title: item.title,
          body: item.description,
          date: DateTime.now(),
          //
          // ignore: use_is_even_rather_than_modulo
          hasAction: index % 2 == 0,
          onActionTap: () {},
        );
        // return NotificationItem(
        //   title: item.title,
        //   body: item.body,
        // );
      },
    );
  }
}

class NotificationItemEx extends StatelessWidget {
  const NotificationItemEx({
    required this.title,
    required this.body,
    this.date,
    this.hasAction = false,
    this.onActionTap,
    super.key,
  });

  final String title;
  final String body;
  final DateTime? date;
  final bool hasAction;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF00897B),
            radius: 20,
            child: Text(
              'M1',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatBubble(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        body,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatTime(date ?? DateTime.now()),
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasAction) ...[
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onActionTap ?? () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 44),
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      elevation: 0,
                    ),
                    child: const Text('Перейти к заданиям'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(this.item, {super.key});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isRead ? Colors.transparent : theme.colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NotificationAvatar(item.avatar),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NotificationCard(
                    title: item.title,
                    description: item.description,
                    time: item.date,
                  ),
                  if (item.action != null) _NotificationActionWidget(item.action!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationActionWidget extends StatelessWidget {
  const _NotificationActionWidget(this.action);

  final NotificationAction action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: action.isActive ? () {} : null,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.maxFinite, 44),
          backgroundColor: theme.colorScheme.onSurface,
          foregroundColor: theme.colorScheme.surface,
          elevation: 0,
        ),
        child: Text(action.buttonText),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.description,
    required this.time,
  });

  final String title;
  final String description;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    return ChatBubble(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              _formatTime(time, locale.languageCode),
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt, String locale) {
    return DateFormat('dd MMM hh:mm', locale).format(dt);
  }
}

class _NotificationAvatar extends StatelessWidget {
  const _NotificationAvatar(this.avatar);

  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: avatar != null ? CachedNetworkImageProvider(avatar!) : Assets.images.appIcon.provider(),
    );
  }
}

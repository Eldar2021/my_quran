import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(this.item, {super.key});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NotificationAvatar(item.avatar ?? ''),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NotificationCard(
                title: item.title,
                description: item.description,
                time: item.date,
                isRead: item.isRead,
                image: item.image,
              ),
              if (item.action != null) _NotificationActionWidget(item.action!),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    this.image,
  });

  final String title;
  final String description;
  final DateTime time;
  final bool isRead;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    return ChatBubble(
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              if (image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: image!,
                      fit: BoxFit.fitHeight,
                      errorWidget: (context, url, error) => const SizedBox(),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _formatTime(time, locale.languageCode),
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          if (!isRead)
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: theme.colorScheme.primary,
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

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: avatar.isNotEmpty ? CachedNetworkImageProvider(avatar) : Assets.images.appIcon.provider(),
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

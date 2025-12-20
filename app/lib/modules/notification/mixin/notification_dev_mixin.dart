import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_storage/mq_storage.dart';

mixin NotificationDevMixin {
  void showDevDialog(BuildContext context) {
    final fcmToken = context.read<PreferencesStorage>().readString(key: 'notification-token');
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

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

mixin NotificationMixin {
  Future<void> initializeNotification(
    AuthModel auth,
    BuildContext context,
  ) async {
    final notificationCubit = context.read<NotificationCubit>();
    final deviceManager = context.read<DeviceManager>();
    try {
      await context.read<NotificationService>().initialize(
        userToken: auth.key,
        locale: auth.user.language ?? 'en',
        onNotificationClick: _onNotificationClick,
        onFirebaseNotificationClick: _onNotificationClick,
        onReceiveNotification: () {
          notificationCubit.getNotificationCount(auth.key);
        },
        onPermissionEnabled: () {
          notificationCubit.toggleNotification(auth.key, true);
        },
        onPermissionDisabled: () {
          notificationCubit.toggleNotification(auth.key, false);
        },
        onSendTokenToServer: (fcmToken) async {
          final [deviceId, deviceTimezone] = await Future.wait([
            deviceManager.getDeviceId(),
            deviceManager.getDeviceTimezone(),
          ]);
          await notificationCubit.setNotificationToken(
            auth: auth,
            fcmToken: fcmToken,
            deviceId: deviceId,
            deviceTimezone: deviceTimezone,
          );
        },
      );
    } on Object catch (e) {
      log('initializeNotification', error: e);
    }
  }

  Future<void> _onNotificationClick(Object? data) async {
    final model = _getNotificationData(data);
    rootNavigatorKey.currentContext?.goNamed(
      AppRouter.notification,
      extra: model,
    );
  }

  NotificationModel? _getNotificationData(Object? data) {
    try {
      Map<String, dynamic> map;
      if (data is String) {
        map = jsonDecode(data) as Map<String, dynamic>;
      } else if (data is Map<String, dynamic>) {
        map = data;
      } else {
        return null;
      }

      final id = map['id'] != null
          ? map['id'] is String
                ? int.tryParse(map['id'] as String)
                : map['id'] is int
                ? map['id'] as int?
                : null
          : null;
      final date = map['date'] != null ? DateTime.tryParse(map['date'] as String) : null;

      return NotificationModel(
        id: id ?? 0,
        isRead: false,
        type: NotificationType.standard,
        title: map['title'] != null ? map['title'] as String : '',
        description: map['description'] != null ? map['description'] as String : '',
        date: date ?? DateTime.now(),
      );
    } on Object catch (e) {
      log('❌ _getNotificationData', error: e);
      return null;
    }
  }
}

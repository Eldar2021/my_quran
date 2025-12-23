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
          notificationCubit.resetNotificationCount();
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
    final model = _parseNotificationModel(data);
    rootNavigatorKey.currentContext?.goNamed(
      AppRouter.notification,
      extra: model,
    );
  }

  NotificationModel? _parseNotificationModel(Object? data) {
    try {
      if (data is String) {
        return NotificationModel.fromJson(
          jsonDecode(data) as Map<String, dynamic>,
        );
      } else if (data is Map<String, dynamic>) {
        return NotificationModel.fromJson(data);
      } else {
        return null;
      }
    } on Object catch (e) {
      log('❌ parseNotificationModel', error: e);
      return null;
    }
  }
}

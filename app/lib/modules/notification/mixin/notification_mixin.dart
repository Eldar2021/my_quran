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
        onPermissionEnabled: () {
          notificationCubit.toggleNotification(auth.key, true);
        },
        onPermissionDisabled: () {
          notificationCubit.toggleNotification(auth.key, false);
        },
        onNotificationClick: (data) {
          rootNavigatorKey.currentContext?.goNamed(
            AppRouter.notification,
          );
        },
        onFirebaseNotificationClick: (data) {
          rootNavigatorKey.currentContext?.goNamed(
            AppRouter.notification,
          );
        },
        onSendTokenToServer: (fcmToken) async {
          final deviceId = await deviceManager.getDeviceId();
          await notificationCubit.setNotificationToken(
            auth: auth,
            fcmToken: fcmToken,
            deviceId: deviceId,
          );
        },
      );
    } on Object catch (e) {
      log('initializeNotification', error: e);
    }
  }
}

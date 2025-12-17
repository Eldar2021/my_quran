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
    try {
      await context.read<NotificationService>().initialize(
        userToken: auth.key,
        locale: auth.user.language ?? 'en',
        onPermissionEnabled: () {
          context.read<NotificationCubit>().toggleNotification(
            userToken: auth.key,
          );
        },
        onPermissionDisabled: () {
          context.read<NotificationCubit>().toggleNotification(
            userToken: auth.key,
            value: false,
          );
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
      );
    } on Object catch (e) {
      log('initializeNotification', error: e);
    }
  }
}

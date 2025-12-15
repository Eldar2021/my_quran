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
    UserModelResponse user,
    BuildContext context,
  ) async {
    try {
      await context.read<NotificationService>().initialize(
        userToken: user.accessToken,
        locale: user.localeCode,
        onPermissionEnabled: () {
          context.read<NotificationCubit>().toggleNotification(
            userToken: user.accessToken,
          );
        },
        onPermissionDisabled: () {
          context.read<NotificationCubit>().toggleNotification(
            userToken: user.accessToken,
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

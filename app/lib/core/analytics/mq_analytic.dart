import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:my_quran/core/core.dart';

part 'mq_analytic_keys.dart';

@immutable
final class MqAnalytic {
  const MqAnalytic._();

  static Future<void> setUserProperty(String userName) async {
    try {
      if (kDebugMode) return;
      await _analytics.setUserProperty(name: userName, value: null);
    } catch (error, stackTrace) {
      MqCrashlytics.report(error, stackTrace);
      log('MqAnalytics setUserProperty error: $error, stackTrace: $stackTrace');
    }
  }

  static void track(String event, {Map<String, dynamic>? params}) {
    try {
      if (kDebugMode) return;
      _analytics.logEvent(name: event, parameters: params);
    } catch (error, stackTrace) {
      MqCrashlytics.report(error, stackTrace);
      log('MqAnalytics track error: $error, stackTrace: $stackTrace');
    }
  }

  static FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
}

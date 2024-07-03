import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';
part 'mq_analytic_keys.dart';

@immutable
final class MqAnalytic {
  const MqAnalytic(FirebaseAnalytics analytics) : _analytics = analytics;

  final FirebaseAnalytics _analytics;

  Future<void> setUserProperty(String userName) async {
    try {
      await _analytics.setUserProperty(name: userName, value: null);
    } catch (error, stackTrace) {
      MqCrashlytics.report(error, stackTrace);
      log('MqAnalytics setUserProperty error: $error, stackTrace: $stackTrace');
    }
  }

  void track(String event, {Map<String, dynamic>? params}) {
    try {
      _analytics.logEvent(name: event, parameters: params);
    } catch (error, stackTrace) {
      MqCrashlytics.report(error, stackTrace);
      log('MqAnalytics track error: $error, stackTrace: $stackTrace');
    }
  }
}

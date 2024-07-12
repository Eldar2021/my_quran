import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MqCrashlytics {
  const MqCrashlytics._();

  static void report(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      debugPrint('exception: $exception\nstack: $stack');
    } else {
      crashlytics.recordError(
        exception,
        stack,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }

  static void recordFlutterError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = false,
  }) {
    if (kDebugMode) {
      debugPrint('exception: $flutterErrorDetails');
    } else {
      crashlytics.recordFlutterError(flutterErrorDetails, fatal: fatal);
    }
  }

  static Future<void> setUserIdentifier(String identifier) async {
    if (kDebugMode) {
      debugPrint('identifier: $identifier');
    } else {
      return crashlytics.setUserIdentifier(identifier);
    }
  }

  static Future<void> setCrashlyticsCollectionEnabled({required bool enabled}) async {
    if (kDebugMode) return;
    return crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  static FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;
}

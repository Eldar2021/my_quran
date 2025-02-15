import 'package:flutter/material.dart';

/// App Text Styles Definitions
abstract class AppTextStyles {
  /// Display Large
  /// Font Size: 57
  /// Font Weight: w700
  static const displayLarge = TextStyle(package: 'mq_app_ui', fontSize: 57, fontWeight: FontWeight.bold);

  /// Display Medium
  /// Font Size: 45
  /// Font Weight: w700
  static const displayMedium = TextStyle(package: 'mq_app_ui', fontSize: 45, fontWeight: FontWeight.bold);

  /// Display Small
  /// Font Size: 36
  /// Font Weight: w700
  static const displaySmall = TextStyle(package: 'mq_app_ui', fontSize: 36, fontWeight: FontWeight.bold);

  /// Headline Large
  /// Font Size: 32
  /// Font Weight: w600
  static const headlineLarge = TextStyle(package: 'mq_app_ui', fontSize: 32, fontWeight: FontWeight.w600);

  /// Headline Medium
  /// Font Size: 28
  /// Font Weight: w600
  static const headlineMedium = TextStyle(package: 'mq_app_ui', fontSize: 28, fontWeight: FontWeight.w600);

  /// Headline Small
  /// Font Size: 24
  /// Font Weight: w500
  static const headlineSmall = TextStyle(package: 'mq_app_ui', fontSize: 24, fontWeight: FontWeight.w500);

  /// Title Large
  /// Font Size: 22
  /// Font Weight: w500
  static const titleLarge = TextStyle(package: 'mq_app_ui', fontSize: 22, fontWeight: FontWeight.w500);

  /// Title Medium
  /// Font Size: 16
  /// Font Weight: w500
  static const titleMedium = TextStyle(package: 'mq_app_ui', fontSize: 16, fontWeight: FontWeight.w500);

  /// Title Small
  /// Font Size: 14
  /// Font Weight: w500
  static const titleSmall = TextStyle(package: 'mq_app_ui', fontSize: 14, fontWeight: FontWeight.w500);

  /// Body Large
  /// Font Size: 16
  /// Font Weight: w400
  static const bodyLarge = TextStyle(package: 'mq_app_ui', fontSize: 16, fontWeight: FontWeight.normal);

  /// Body Medium
  /// Font Size: 14
  /// Font Weight: w400
  static const bodyMedium = TextStyle(package: 'mq_app_ui', fontSize: 14, fontWeight: FontWeight.normal);

  /// Body Small
  /// Font Size: 12
  /// Font Weight: w400
  static const bodySmall = TextStyle(package: 'mq_app_ui', fontSize: 12, fontWeight: FontWeight.normal);

  /// Label Large
  /// Font Size: 14
  /// Font Weight: w500
  static const labelLarge = TextStyle(package: 'mq_app_ui', fontSize: 14, fontWeight: FontWeight.w500);

  /// Label Medium
  /// Font Size: 12
  /// Font Weight: w500
  static const labelMedium = TextStyle(package: 'mq_app_ui', fontSize: 12, fontWeight: FontWeight.w500);

  /// Label Small
  /// Font Size: 11
  /// Font Weight: w500
  static const labelSmall = TextStyle(package: 'mq_app_ui', fontSize: 11, fontWeight: FontWeight.w500);
}

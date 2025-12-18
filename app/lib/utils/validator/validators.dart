import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

abstract interface class Validators {
  static String? email(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return context.l10n.enterEmail;
    if (!AppRegExp.email.hasMatch(value)) return context.l10n.enterEmail;
    return null;
  }

  static String? otpValidator(
    String? value,
    BuildContext context, {
    int length = 4,
  }) {
    if (value == null || value.length < length) {
      return context.l10n.enterVerificationCode;
    }
    return null;
  }
}

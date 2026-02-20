import 'package:flutter/cupertino.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

final class QuranAmenDialogContentArgs {
  const QuranAmenDialogContentArgs({
    required this.readThemeState,
    required this.confirmMessage,
    required this.pages,
    this.gender = Gender.male,
    this.hatimId,
    this.onAmen,
  });

  final QuranBookSettingsState readThemeState;
  final List<int> pages;
  final Gender gender;
  final String confirmMessage;
  final String? hatimId;
  final void Function(BuildContext context, bool result)? onAmen;
}

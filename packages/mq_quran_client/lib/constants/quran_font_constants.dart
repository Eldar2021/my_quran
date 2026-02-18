import 'dart:io';

import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranFontConstants {
  static String get surahNamesFont {
    return Platform.isIOS || Platform.isMacOS ? QuranFontFamily.surahNames : QuranFontFamily.surahNamesTtf;
  }
}

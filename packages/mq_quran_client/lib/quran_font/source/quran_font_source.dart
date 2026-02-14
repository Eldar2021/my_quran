import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranFontSource {
  Future<QuranFontModel> getFontByPage(int pageNumber);
}

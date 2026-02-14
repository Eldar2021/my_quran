import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranFontRepository {
  Future<QuranFontModel> getFontByPage(int pageNumber);
}

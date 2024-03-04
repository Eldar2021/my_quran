import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class ReadRemoteDataSource {
  const ReadRemoteDataSource(this.remoteClient);

  final RemoteClient remoteClient;

  Future<QuranPage?> fetchPage(int page, String quranFmt) async {
    final remoteValue = await remoteClient.get<QuranPage>(
      apiConst.verse(page, quranFmt),
      fromJson: QuranPage.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }
}

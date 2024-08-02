import 'package:meta/meta.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadRemoteDataSourceImpl implements ReadRemoteDataSource {
  const ReadRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt) async {
    final remoteValue = await remoteClient.getType<QuranPageResponse>(
      apiConst.verse(page, quranFmt),
      fromJson: QuranPageResponse.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }
}

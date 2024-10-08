import 'dart:convert';
import 'dart:developer';
import 'package:meta/meta.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class NamazTimesRemoteDataSourceImpl implements PlaceTimesRemoteDataSource {
  const NamazTimesRemoteDataSourceImpl(this.remoteClient);
  final MqRemoteClient remoteClient;

  @override
  Future<NamazTimesResponse> getNamazTimes(int placeId) async {
    final remoteValue = await remoteClient.get<String>(
      apiConst.nasaatMediaNamazTimesApi(placeId),
    );

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data $left'),
      (right) {
        final m = jsonDecode(right) as Map<String, dynamic>;

        return NamazTimesResponse.fromJson(m);
      },
    );
  }

  @override
  Future<ContinentModelResponse> getContinents() async {
    final remoteValue = await remoteClient.get<String>(apiConst.nasaatMediaContinentsApi);

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data ${left.error}'),
      (right) {
        final m = jsonDecode(right) as Map<String, dynamic>;
        log(m.toString());
        log(ContinentModelResponse.fromJson(m).list.toString());
        return ContinentModelResponse.fromJson(m);
      },
    );
  }

  @override
  Future<RegionModelResponse> getRegions(int continentId) async {
    final remoteValue = await remoteClient.get<String>(
      apiConst.nasaatMediaNamazTimesApi(continentId),
    );

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data $left'),
      (right) {
        final m = jsonDecode(right) as Map<String, dynamic>;

        return RegionModelResponse.fromJson(m);
      },
    );
  }
}

import 'package:my_quran/modules/namaz_time/namaz_time.dart';

abstract class PlaceTimesRemoteDataSource {
  Future<NamazTimesResponse> getNamazTimes(int placeId);
  Future<ContinentModelResponse> getContinents();
  Future<RegionModelResponse> getRegions(int continentId);
}

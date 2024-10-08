import 'package:my_quran/modules/modules.dart';

abstract class NamazTimesRepository {
  Future<NamazTimesEntity> getNamazTimes(int placeId);
  Future<ContinentsEntity> getContinents();
  Future<RegionsEntity> getRegions(int continentId);
}

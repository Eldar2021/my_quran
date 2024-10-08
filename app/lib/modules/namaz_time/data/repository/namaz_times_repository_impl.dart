import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class NamazTimesRepositoryImpl implements NamazTimesRepository {
  const NamazTimesRepositoryImpl(this.remoteDataSource);
  final NamazTimesRemoteDataSourceImpl remoteDataSource;

  @override
  Future<NamazTimesEntity> getNamazTimes(int placeId) async {
    try {
      final remoteData = await remoteDataSource.getNamazTimes(placeId);

      return _convertDataNamazTime(remoteData);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('NamazRepositoryImpl, getData error: $e');
      return const NamazTimesEntity(
        title: 'testtitle',
        titleRu: 'titleRu',
        titleEn: 'titleEn',
        lat: 1,
        lon: 1,
        bagymdatOffset: 1,
        sunriseOffset: 1,
        zuhrOffset: 1,
        asrOffset: 1,
        magribOffset: 1,
        ishaOffset: 1,
        timezone: ' 1',
        id: 1,
        subLocations: [],
      );
    }
  }

  NamazTimesEntity _convertDataNamazTime(NamazTimesResponse response) {
    return NamazTimesEntity(
      title: response.title,
      titleRu: response.titleRu,
      titleEn: response.titleEn,
      lat: response.lat,
      lon: response.lon,
      bagymdatOffset: response.bagymdatOffset,
      sunriseOffset: response.sunriseOffset,
      zuhrOffset: response.zuhrOffset,
      asrOffset: response.asrOffset,
      magribOffset: response.magribOffset,
      ishaOffset: response.ishaOffset,
      timezone: response.timezone,
      id: response.id,
      subLocations: response.subLocations ?? [],
    );
  }

  @override
  Future<ContinentsEntity> getContinents() async {
    try {
      final remoteData = await remoteDataSource.getContinents();

      return _convertDataContinents(remoteData);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('NamazRepositoryImpl, getData error: $e');
      return const ContinentsEntity(list: []);
    }
  }

  ContinentsEntity _convertDataContinents(ContinentModelResponse response) {
    return ContinentsEntity(list: response.list);
  }

  @override
  Future<RegionsEntity> getRegions(int continentId) async {
    try {
      final remoteData = await remoteDataSource.getRegions(continentId);

      return _convertRegions(remoteData);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('NamazRepositoryImpl, getData error: $e');
      return const RegionsEntity(
        title: 'testtitle',
        titleRu: 'titleRu',
        titleEn: 'titleEn',
        lat: 1,
        lon: 1,
        id: 1,
        list: [],
      );
    }
  }

  RegionsEntity _convertRegions(RegionModelResponse response) {
    return RegionsEntity(
      id: response.id,
      list: response.list,
      title: response.title,
      titleRu: response.titleRu,
      titleEn: response.titleEn,
      lat: response.lat,
      lon: response.lon,
      bagymdatOffset: response.bagymdatOffset,
      sunriseOffset: response.sunriseOffset,
      zuhrOffset: response.zuhrOffset,
      asrOffset: response.asrOffset,
      magribOffset: response.magribOffset,
      ishaOffset: response.ishaOffset,
      timezone: response.timezone,
      secondTimezone: response.secondTimezone,
      useFormula: response.useFormula,
      startDateTz: response.startDateTz,
      startDateSecondTz: response.startDateSecondTz,
    );
  }
}

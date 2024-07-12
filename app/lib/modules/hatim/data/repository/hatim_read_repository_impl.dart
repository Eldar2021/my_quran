import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HatimReadRepositoryImpl implements HatimRepository {
  const HatimReadRepositoryImpl({required this.dataSource});

  final HatimRemoteDataSource dataSource;

  @override
  Future<HatimReadEntity> getHatim() async {
    final res = await dataSource.getHatim();
    return res.toEntity;
  }

  @override
  void connectToSocket(String token) {
    dataSource.connectToSocket(token);
  }

  @override
  Stream<(HatimResponseType, List<HatimBaseEntity>)> get stream {
    return dataSource.stream.map((data) {
      final src = HatimBaseResponse.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );

      return switch (src.type) {
        HatimResponseType.listOfJuz => _receidevJuzs(src.data as List<dynamic>),
        HatimResponseType.listOfPage => _receidevJuzPage(src.data as List<dynamic>),
        HatimResponseType.userPages => _receidevUserPages(src.data as List<dynamic>),
      };
    });
  }

  (HatimResponseType, List<HatimJusEntity>) _receidevJuzs(List<dynamic> src) {
    final data = src.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfJuz, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<HatimPagesEntity>) _receidevJuzPage(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfPage, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<HatimPagesEntity>) _receidevUserPages(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.userPages, data.map((e) => e.entity).toList());
  }

  @override
  void sinkHatimJuzs(String hatimId) => dataSource.sinkHatimJuzs(hatimId);

  @override
  void sinkHatimUserPages() => dataSource.sinkHatimUserPages();

  @override
  void sinkHatimJuzPages(String juzId) => dataSource.sinkHatimJuzPages(juzId);

  @override
  void sinkSelectPage(String pageId) => dataSource.sinkSelectPage(pageId);

  @override
  void sinkUnSelectPage(String pageId) => dataSource.sinkUnSelectPage(pageId);

  @override
  void sinkInProgressPages(List<String> pageIds) => dataSource.sinkInProgressPages(pageIds);

  @override
  void sinkDonePages(List<String> pageIds) => dataSource.sinkDonePages(pageIds);

  @override
  Future<void> close() async => dataSource.close();
}

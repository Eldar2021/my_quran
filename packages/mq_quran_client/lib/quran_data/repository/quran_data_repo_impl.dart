import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranDataRepoImpl implements QuranDataRepository {
  const QuranDataRepoImpl();

  @override
  Future<QuranPageModel> getVersesByPage(
    int pageNumber, {
    int? sortSurahNumber,
    int? sortJuzNumber,
  }) async {
    try {
      final response = await rootBundle.loadString(_getPagePath(pageNumber));
      final data = json.decode(response) as List<dynamic>;
      log(data.toString());
      final list = data.map((json) => QuranVerseModel.fromJson(json as Map<String, dynamic>)).toList();
      if (sortSurahNumber != null) {
        return QuranPageModel(
          pageNumber: pageNumber,
          verses: list.where((e) => e.hizbNumber == sortSurahNumber).toList(),
        );
      }

      if (sortJuzNumber != null) {
        return QuranPageModel(
          pageNumber: pageNumber,
          verses: list.where((e) => e.juzNumber == sortJuzNumber).toList(),
        );
      }

      return QuranPageModel(
        pageNumber: pageNumber,
        verses: list,
      );
    } on Object catch (e) {
      log('QuranDataRepoImpl getVersesByPage error($pageNumber): $e');
      rethrow;
    }
  }

  String _getPagePath(int pageNumber) {
    final formattedPage = pageNumber.toString().padLeft(3, '0');
    return 'packages/mq_quran_client/assets/quran_pages/$formattedPage.json';
  }
}

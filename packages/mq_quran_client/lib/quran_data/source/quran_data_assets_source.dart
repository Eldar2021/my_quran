import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranDataAssetsSource implements QuranDataDataSource {
  const QuranDataAssetsSource();

  @override
  Future<List<QuranVerseModel>> getVersesByPage(int pageNumber) async {
    try {
      final response = await rootBundle.loadString(_getPagePath(pageNumber));
      final data = json.decode(response) as List<dynamic>;
      return data.map((json) => QuranVerseModel.fromJson(json as Map<String, dynamic>)).toList();
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

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/models/models.dart';

class FetchPageRepo {
  final dio = Dio();

  Future<List<Verse>?> gerVerses(int page) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(ApiConst.verse(page));
      final versesString = response.data!['verses'] as List;
      return versesString.map((e) => Verse.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      log('$e');
      return null;
    }
  }
}

final fetchPageRepo = FetchPageRepo();

import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';

mixin ParseHatimDataMixin {
  (HatimResponseType, List<MqHatimBaseEntity>) parseHatimData(dynamic data) {
    final src = HatimBaseResponse.fromJson(
      jsonDecode(data as String) as Map<String, dynamic>,
    );
    return switch (src.type) {
      HatimResponseType.listOfJuz => _receiveJuzs(src.data as List<dynamic>),
      HatimResponseType.listOfPage => _receiveJuzPage(src.data as List<dynamic>),
      HatimResponseType.userPages => _receiveUserPages(src.data as List<dynamic>),
    };
  }

  (HatimResponseType, List<MqHatimJusEntity>) _receiveJuzs(List<dynamic> src) {
    final data = src.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfJuz, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receiveJuzPage(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfPage, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receiveUserPages(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.userPages, data.map((e) => e.entity).toList());
  }
}

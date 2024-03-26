import 'dart:developer';

import 'package:meta/meta.dart';

@immutable
final class ParseParams {
  const ParseParams._();

  static (List<int>, bool) parseRead(Map<String, String> args) {
    try {
      final isHatim = args['isHatim'] == 'true';
      final p1 = args['pages'] ?? '[1]';
      final pages = p1.substring(1, p1.length - 1).split(',').map(int.parse).toList();
      return (pages, isHatim);
    } catch (e) {
      log(e.toString());
      return ([1], false);
    }
  }
}

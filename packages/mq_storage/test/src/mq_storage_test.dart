// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mq_storage/mq_storage.dart';

void main() {
  group('MqStorage', () {
    test('can be instantiated', () {
      expect(MqStorage(), isNotNull);
    });
  });
}

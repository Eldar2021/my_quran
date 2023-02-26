// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mq_client/mq_client.dart';

void main() {
  group('MqClient', () {
    test('can be instantiated', () {
      expect(MqClient(), isNotNull);
    });
  });
}

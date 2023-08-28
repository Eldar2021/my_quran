import 'package:mq_ci_keys/src/mq_ci_keys_base.dart';
import 'package:test/test.dart';

void main() {
  group('MqClient', () {
    test('can be instantiated', () {
      expect(MqKeys(), isNotNull);
    });
  });
}

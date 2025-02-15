import 'package:mq_either/mq_either.dart';
import 'package:test/test.dart';

void main() {
  group('Either', () {
    test('Return type is correctly', () {
      final rightResult = _successMethod();
      final failedResult = _failedMethod();

      final rightResultValue = switch (rightResult) {
        Right() => 'Test Value ${rightResult.value}',
        Left() => 'Test Value ${rightResult.value}',
      };

      final failedResultValue = switch (failedResult) {
        Right() => 'Test Value ${failedResult.value}',
        Left() => 'Test Value ${failedResult.value}',
      };

      expect(rightResultValue, 'Test Value 17');
      expect(failedResultValue, 'Test Value Error');
    });

    test('Right value should fold correctly', () {
      const rightValue = Right<int, String>(42);

      final result = rightValue.fold((error) => 'Left: $error', (value) => 'Right: $value');

      expect(result, 'Right: 42');
    });

    test('Left value should fold correctly', () {
      const leftValue = Left<int, String>('Error');

      final result = leftValue.fold((error) => 'Left: $error', (value) => 'Right: $value');

      expect(result, 'Left: Error');
    });
  });
}

Either<int, String> _successMethod() => const Right(17);
Either<int, String> _failedMethod() => const Left('Error');

import 'package:comprei/adapters/number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Percentil 95 tests', () {
    test('Should calculate a percentil 95 from a list of numbers', () {
      final numList = [10, 3, 3, 3, 3, 3, 7, 3, 2, 1, 3, 5];

      expect(7, numList.perc95());
    });
  });
}

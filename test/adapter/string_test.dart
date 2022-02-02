import 'package:flutter_test/flutter_test.dart';
import 'package:comprei/adapters/string.dart';

void main() {
  group('String adapter tests', () {
    test('Extract just number from a string with letters and whitespaces', () {
      const targetStr = 'Abcf123  ghjk 4556 6 g3e ';

      expect(targetStr.onlyNumbers(), '123455663');
    });

    test(
        'Extract just number from a string with letters new lines and special chars',
        () {
      const targetStr = '''
              Abcf123#  ghjk 455!@6 6 g3e\n

              4\n8
              ''';

      expect(targetStr.onlyNumbers(), '12345566348');
    });

    test(
        'Extract just decimals number from a string with letters new lines and special chars',
        () {
      const targetStr = '''
              Abcf123#  ghjk 4,55!@ge\n

              4\n
              ''';

      expect(targetStr.onlyDecimals(), '1234.554');
    });
  });
}

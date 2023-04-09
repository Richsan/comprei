import 'package:comprei/adapters/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date adapter tests', () {
    test('Brings a list of days difference from a list of datetimes', () {
      final dateList = [
        DateTime.parse('2023-01-01'),
        DateTime.parse('2023-01-02'),
        DateTime.parse('2023-01-08'),
      ];

      expect([0, 1, 6], dateList.toDaysDiff());
    });

    test('Brings a list of days difference from an empty list', () {
      final dateList = List<DateTime>.empty();

      expect([], dateList.toDaysDiff());
    });

    test('Brings a list of days difference from a single item list', () {
      final dateList = [DateTime.parse('2023-01-01')];

      expect([0], dateList.toDaysDiff());
    });

    test('Brings a list of days difference from a unordered list of datetimes',
        () {
      final dateList = [
        DateTime.parse('2023-01-02'),
        DateTime.parse('2023-01-08'),
        DateTime.parse('2023-01-01'),
      ];

      expect([0, 1, 6], dateList.toDaysDiff());
    });
  });
}

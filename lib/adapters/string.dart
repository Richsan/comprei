import 'package:comprei/adapters/number.dart';

extension StringAdapter on String {
  String onlyNumbers() {
    return replaceAll(' ', '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String onlyDecimals() {
    return replaceAll(' ', '')
        .replaceAll(RegExp(r'[^\d,]'), '')
        .replaceAll(',', '.');
  }

  int asMoney() {
    return double.parse(onlyDecimals()).asMoneyInt();
  }
}

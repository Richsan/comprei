import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

extension CurrencyFormatter on int {
  String asCurrency() {
    return currencyFormat.format(this / 100);
  }
}

extension MoneyExtractor on double {
  int asMoneyInt() {
    return (this * 100).round().toInt();
  }
}

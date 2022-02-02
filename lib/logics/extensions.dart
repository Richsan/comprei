import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

extension CurrencyFormatter on int {
  String toCurrency() {
    return currencyFormat.format(this);
  }
}

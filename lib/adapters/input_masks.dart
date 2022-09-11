import 'package:comprei/adapters/number.dart';
import 'package:comprei/adapters/string.dart';
import 'package:flutter/services.dart';

class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numbersText = newValue.text.onlyNumbers();

    if (numbersText.isEmpty) {
      return oldValue;
    }

    int value = int.parse(numbersText);

    String newText = value.asCurrency();
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class Mask {
  Mask({
    required this.formatter,
    this.keyboardType,
  });

  final TextInputFormatter formatter;
  final TextInputType? keyboardType;
}

final masks = {
  "currency": Mask(
    formatter: _CurrencyInputFormatter(),
    keyboardType: TextInputType.number,
  ),
  "alphabetic": Mask(
    formatter: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z\\s]')),
  ),
  "numeric": Mask(
    formatter: FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    keyboardType: TextInputType.number,
  ),
  "decimal": Mask(
    formatter: FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
    keyboardType: TextInputType.number,
  ),
  "alphanumeric": Mask(
    formatter: FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z\\s]')),
  ),
};

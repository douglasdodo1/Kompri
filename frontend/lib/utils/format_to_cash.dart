import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String onlyDigits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    print(" ONLYDIGITS: $onlyDigits");

    if (onlyDigits.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(onlyDigits) / 100;
    print(" VALUE: $value");

    final newString = _formatter.format(value).trim();
    print(" NEWSTRING: $newString");

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}

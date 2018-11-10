import 'package:flutter/services.dart';

RegExp _correctDecimalRegExp = new RegExp(r"^\d*(\d\.)?\d*$");

class DecimalTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
    ) {
    if (_correctDecimalRegExp.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

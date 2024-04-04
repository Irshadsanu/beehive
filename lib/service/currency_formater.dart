import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

     if(newValue.text.length>3){
      double value = double.parse(newValue.text);
      final formatter = NumberFormat.currency(locale: 'HI',symbol: '',decimalDigits: 0);
      String newText = formatter.format(value);
      return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length));
    }else{
      return newValue;
    }


  }
}
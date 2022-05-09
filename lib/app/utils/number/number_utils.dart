import 'package:intl/intl.dart';

class NumberUtils {
  static String convertNumberToK(String number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(double.parse(number));
  }
}

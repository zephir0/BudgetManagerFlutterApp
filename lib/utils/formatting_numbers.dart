import 'package:intl/intl.dart';

class NumberFormatter {
  String getFormattedNumber(double number) {
    var formatter = new NumberFormat("#,###.00");
    return formatter.format(number);
  }
}

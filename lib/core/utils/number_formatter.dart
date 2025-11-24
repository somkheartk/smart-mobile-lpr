import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatNumber(num number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  static String formatDecimal(num number, {int decimalPlaces = 2}) {
    return number.toStringAsFixed(decimalPlaces);
  }

  static String formatPercentage(num number, {int decimalPlaces = 1}) {
    return '${number.toStringAsFixed(decimalPlaces)}%';
  }

  static String formatCurrency(num amount, {String symbol = '฿'}) {
    final formatter = NumberFormat('#,###.00');
    return '$symbol${formatter.format(amount)}';
  }

  static String formatCompactNumber(num number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

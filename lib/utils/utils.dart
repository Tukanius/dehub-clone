import 'package:intl/intl.dart';

class Utils {
  formatCurrency(value) {
    var result;
    if (value == '0.00' || value == '0' || value == "0.0") {
      return result = '0.00';
    }
    var formattedNumber =
        NumberFormat("#,###.00", "en_US").format(double.parse(value));
    result = formattedNumber.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}'");

    return result;
  }
}

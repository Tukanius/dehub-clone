import 'package:intl/intl.dart';

class Utils {
  formatCurrency(String? value) {
    var result;
    if (value == '0.00' || value == '0' || value == "0.0") {
      return result = '0';
    }
    var formattedNumber =
        NumberFormat("#,###", "en_US").format(double.parse(value.toString()));
    result = formattedNumber.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}'");

    return result;
  }
}

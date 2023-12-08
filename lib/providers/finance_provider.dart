import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  Color golomt = Color(0xff6872F9);
  Color bogd = Color(0xff006B60);
  Color dehub = Color(0xff2e3192);
  Color currentColor = Color(0xff000000);
  String bankName = '';

  colorChange(String value) {
    value == "Богд Банк"
        ? currentColor = bogd
        : value == "Голомт Банк"
            ? currentColor = golomt
            : currentColor = dehub;
    bankName = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  Color golomt = Color(0xff6872F9);
  Color bogd = Color(0xff006B60);
  Color dehub = Color(0xff2e3192);
  Color currentColor = Color(0xff000000);
  String url = '';
  String bankName = '';

  bankSelect(String value) {
    value == "Богд Банк"
        ? {
            currentColor = bogd,
            url = 'http://dev-de-fi-bogd.zto.mn',
          }
        : value == "Голомт Банк"
            ? {
                currentColor = golomt,
                url = 'http://dev-de-fi-golomt.zto.mn',
              }
            : {
                currentColor = dehub,
                url = 'http://dev-de-fi.zto.mn',
              };
    bankName = value;
    notifyListeners();
  }
}

import 'package:dehub/models/bank_accounts.dart';
import 'package:dehub/models/finance.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  Color golomt = const Color(0xff6872F9);
  Color bogd = const Color(0xff006B60);
  Color dehub = const Color(0xff2e3192);
  Color currentColor = const Color(0xff000000);
  String url = '';
  String bankName = '';
  String type = '';
  Finance finance = Finance();

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

  contractFiles(String url) {
    finance.contractFile = url;
    notifyListeners();
  }

  productType(String type) {
    this.type = type;
    notifyListeners();
  }

  requestedAmount(double? amount) {
    finance.requestedAmount = amount;
    notifyListeners();
  }

  contractAgreement(bool value) {
    finance.isApproved = value;
    notifyListeners();
  }

  bankAccountSelect(BankAccounts data) {
    finance.account = data;
    notifyListeners();
  }

  clearData() {
    finance = Finance();
    notifyListeners();
  }
}

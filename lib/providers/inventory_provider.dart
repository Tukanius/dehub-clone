import 'package:flutter/material.dart';

class InventoryProvider extends ChangeNotifier {
  String? skuCode;
  String? barCode;
  String? erpCode;
  String? nameMon;
  String? name;
  String? padName;
  String? appName;
  String? webName;
  String brandName = 'Сонгох';
  String supplierName = 'Сонгох';

  brand(String value) {
    brandName = value;
    notifyListeners();
  }

  supplier(String value) {
    supplierName = value;
    notifyListeners();
  }

  clearData() {
    skuCode = null;
    barCode = null;
    erpCode = null;
    nameMon = null;
    name = null;
    padName = null;
    appName = null;
    webName = null;
    brandName = 'Сонгох';
    supplierName = 'Сонгох';
    notifyListeners();
  }
}

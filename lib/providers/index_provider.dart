import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int selectedIndex = 1;
  int newProductIndex = 0;

  indexChange(index) {
    selectedIndex = index;
    notifyListeners();
  }

  newProductIndexChange(int index) {
    newProductIndex = index;
    notifyListeners();
  }
}

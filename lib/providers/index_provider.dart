import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int selectedIndex = 1;
  indexChange(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int selectedIndex = 1;
  networkIndexChange(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

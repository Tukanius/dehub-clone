import 'dart:io';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  int selectedIndex = 1;
  int newProductIndex = 0;
  File? file;

  indexChange(index) {
    selectedIndex = index;
    notifyListeners();
  }

  newProductIndexChange(int index) {
    newProductIndex = index;
    notifyListeners();
  }

  image(File data) {
    file = data;
    notifyListeners();
  }

  clearData() {
    file = null;
    notifyListeners();
  }
}

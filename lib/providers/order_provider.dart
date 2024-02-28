import 'package:dehub/models/order.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> backorderList = [];

  addBackOrder(Order data) {
    backorderList.add(data);
    notifyListeners();
  }

  removeBackOrder(int index) {
    backorderList.removeAt(index);
    notifyListeners();
  }

  clearData() {
    backorderList = [];
    notifyListeners();
  }
}

import 'package:dehub/models/order.dart';
import 'package:flutter/cupertino.dart';

class ListenController extends ChangeNotifier {
  String? value;
  String? listValue;
  Order? customerOrder;
  Order? productOrder;
  Order? additionalRows;
  Order? receiverBranch;
  Order? productChoose;
  Order? file;
  List<Order>? productInPackage;
  int? index;
  ListenController();

  changeVariable(String value) {
    this.value = value;
    notifyListeners();
  }

  refreshList(String value) {
    listValue = value;
    notifyListeners();
  }

  customerOrderChange(Order value) {
    customerOrder = value;
    notifyListeners();
  }

  productOrderChange(Order value) {
    productOrder = value;
    notifyListeners();
  }

  additionalRowsChange(Order value) {
    additionalRows = value;
    notifyListeners();
  }

  receiverBranchChange(Order value) {
    receiverBranch = value;
    notifyListeners();
  }

  filPickerChange(Order value) {
    file = value;
    notifyListeners();
  }

  orderPackageProduct(List<Order> value) {
    productInPackage = value;
    notifyListeners();
  }

  changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  chooseProduct(Order value) {
    productChoose = value;
    notifyListeners();
  }
}

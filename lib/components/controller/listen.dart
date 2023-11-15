import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

class ListenController extends ChangeNotifier {
  String? value;
  String? listValue;
  Invoice? invoice;
  Invoice? partnerInvoice;
  Invoice? goodsInvoice;
  Invoice? sectorInvoice;
  Invoice? invoiceAdditionalRow;
  Order? customerOrder;
  Order? productOrder;
  Order? additionalRows;
  Order? receiverBranch;
  Order? productChoose;
  FilePickerResult? result;
  List<Order>? productInPackage;
  int? index;
  ListenController();

  changeVariable(String value) {
    this.value = value;
    notifyListeners();
  }

  refreshList(String value) {
    this.listValue = value;
    notifyListeners();
  }

  invoiceChange(Invoice value) {
    this.invoice = value;
    notifyListeners();
  }

  partnerInvoiceChange(Invoice value) {
    this.partnerInvoice = value;
    notifyListeners();
  }

  sectorInvoiceChange(Invoice value) {
    this.sectorInvoice = value;
    notifyListeners();
  }

  customerOrderChange(Order value) {
    this.customerOrder = value;
    notifyListeners();
  }

  goodsInvoiceChange(Invoice value) {
    this.goodsInvoice = value;
    notifyListeners();
  }

  productOrderChange(Order value) {
    this.productOrder = value;
    notifyListeners();
  }

  additionalRowsChange(Order value) {
    this.additionalRows = value;
    notifyListeners();
  }

  invoiceAddRow(Invoice value) {
    this.invoiceAdditionalRow = value;
    notifyListeners();
  }

  receiverBranchChange(Order value) {
    this.receiverBranch = value;
    notifyListeners();
  }

  filPickerChange(FilePickerResult? value) {
    this.result = value;
    notifyListeners();
  }

  orderPackageProduct(List<Order> value) {
    this.productInPackage = value;
    notifyListeners();
  }

  changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  chooseProduct(Order value) {
    this.productChoose = value;
    notifyListeners();
  }
}

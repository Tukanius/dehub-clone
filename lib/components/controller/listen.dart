import 'package:dehub/models/invoice.dart';
import 'package:flutter/cupertino.dart';

class ListenController extends ChangeNotifier {
  String? value;
  String? listValue;
  Invoice? invoice;
  Invoice? partnerInvoice;
  Invoice? goodsInvoice;

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

  goodsInvoiceChange(Invoice value) {
    this.goodsInvoice = value;
    notifyListeners();
  }
}

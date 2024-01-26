import 'package:dehub/models/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceProvider extends ChangeNotifier {
  Invoice newInvoice = Invoice();
  List<Invoice> additionalLines = [];
  List<Invoice> products = [];
  List<Invoice> packageProduct = [];
  double totalAmount = 0;
  double finalAmount = 0;
  double totalVatAmount = 0;
  double totalTaxAmount = 0;
  double discountAmount = 0;
  double shippingAmount = 0;
  double addtionalRowAmount = 0;
  double amount = 0;

  partnerChoose(Invoice data) {
    newInvoice.partner = data;
    notifyListeners();
  }

  branchChoose(Invoice data) {
    newInvoice.receiverBranch = data.branch;
    notifyListeners();
  }

  sectorChoose(Invoice data) {
    newInvoice.senderBranch = data.branch;
    notifyListeners();
  }

  additionalRow(Invoice data, String discount, String shipping) {
    additionalLines.add(data);
    totalAmountInvoice(discount, shipping);
    notifyListeners();
  }

  additionalRowRemove(int index, String discount, String shipping) {
    additionalLines.removeAt(index);
    totalAmountInvoice(discount, shipping);
    notifyListeners();
  }

  packageProductRemove(Invoice data) {
    int index = packageProduct.indexWhere((item) => item.id == data.id);
    packageProduct.removeAt(index);
    notifyListeners();
  }

  packageProductClear() {
    packageProduct = [];
    notifyListeners();
  }

  packageProductAdd(Invoice data, int qty) {
    int? index;
    try {
      index = packageProduct.indexWhere((item) => item.id == data.id);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (index! > -1) {
      packageProduct[index].quantity = qty;
    } else {
      packageProduct.add(data);
    }
    notifyListeners();
  }

  addCart(Invoice product, int qty, String discount, String shipping) {
    int? index;
    try {
      index = products.indexWhere((item) => item.id == product.id);
    } catch (e) {
      debugPrint(e.toString());
    }

    if (index! > -1) {
      if (products[index].quantity != 0) {
        products[index].quantity = products[index].quantity! + qty;
      } else {
        removeCart(products[index], discount, shipping);
      }
    } else {
      products.add(product);
    }
    totalAmountInvoice(discount, shipping);

    notifyListeners();
  }

  removeCart(Invoice cart, String discount, String shipping) {
    int index = products.indexWhere((item) => item.id == cart.id);
    products.removeAt(index);
    totalAmountInvoice(discount, shipping);
    notifyListeners();
  }

  discountType(String type, String discount, String shipping) {
    newInvoice.discountType = type;
    totalAmountInvoice(discount, shipping);
    notifyListeners();
  }

  totalAmountInvoice(String discount, String shipping) {
    totalVatAmount = products.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.vatAmount!));
    totalTaxAmount = products.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.taxAmount!));
    amount = products.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    addtionalRowAmount = additionalLines.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    if (newInvoice.discountType == 'Хувиар') {
      discountAmount = totalAmount / 100 * (double.tryParse(discount) ?? 0);
    } else if (newInvoice.discountType == 'Дүнгээр') {
      discountAmount = double.tryParse(discount) ?? 0;
    }
    totalAmount = amount + totalTaxAmount + totalVatAmount + addtionalRowAmount;
    finalAmount = totalAmount;
    finalAmount =
        finalAmount + ((double.tryParse(shipping) ?? 0) - discountAmount);
    notifyListeners();
  }

  clearData() {
    newInvoice = Invoice(discountType: "Сонгох");
    additionalLines = [];
    products = [];
    packageProduct = [];
    totalAmount = 0;
    finalAmount = 0;
    totalVatAmount = 0;
    totalTaxAmount = 0;
    discountAmount = 0;
    shippingAmount = 0;
    addtionalRowAmount = 0;
    amount = 0;
    notifyListeners();
  }
}

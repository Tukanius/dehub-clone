import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/order.dart';
import 'package:flutter/material.dart';

class CheckOutProvider extends ChangeNotifier {
  List<Invoice> invoice = [];
  List<Invoice> additionalRow = [];
  List<Order> order = [];
  List<Order> additional = [];
  List<Order> packageProduct = [];
  String type = 'Сонгох';
  double totalAmount = 0;
  double finalAmount = 0;
  double totalVatAmount = 0;
  double totalTaxAmount = 0;
  double total = 0;
  double shippingAmount = 0;
  double discountAmount = 0;
  double additionalRowAmount = 0;

  package(Order product, int qty) {
    int index = packageProduct.indexWhere((item) => item.id == product.id);

    if (index > -1) {
      packageProduct[index].quantity = packageProduct[index].quantity! + qty;
    } else {
      packageProduct.add(
        product,
      );
    }

    notifyListeners();
  }

  // ******************************************
  // InvoiceProducts
  addCart(Invoice product, int qty) {
    int? index;
    try {
      index = invoice.indexWhere((item) => item.id == product.id);
    } catch (e) {
      debugPrint(e.toString());
    }

    if (index! > -1) {
      if (invoice[index].quantity != 0) {
        invoice[index].quantity = invoice[index].quantity! + qty;
      } else {
        removeCart(invoice[index]);
      }
    } else {
      invoice.add(
        product,
      );
    }
    totalAmountInvoice(type, invoice, shippingAmount, discountAmount);

    notifyListeners();
  }

  removeCart(Invoice cart) {
    int index = invoice.indexWhere((item) => item.id == cart.id);
    invoice.removeAt(index);
    notifyListeners();
  }

  clearCart() {
    invoice = [];
    order = [];
    notifyListeners();
  }

  updateTotalAmountInvoice(
      String type, double shippingAmount, double discountAmount) {
    if (type == 'Хувиар') {
      discountAmount = totalAmount / 100 * discountAmount;
    } else if (type == 'Дүнгээр') {
      discountAmount = discountAmount;
    }

    finalAmount = totalAmount;
    finalAmount = finalAmount + (shippingAmount - discountAmount);
  }

  totalAmountInvoice(String type, List<Invoice> list, double shippingAmount,
      double discountAmount) {
    totalVatAmount = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.vatAmount!));
    totalTaxAmount = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.taxAmount!));
    total = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    additionalRowAmount = additionalRow.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    totalAmount = total + totalTaxAmount + totalVatAmount + additionalRowAmount;
    finalAmount = totalAmount;
    updateTotalAmountInvoice(type, shippingAmount, discountAmount);
    notifyListeners();
  }

  // ******************************************
  // OrderProducts
  orderCart(Order product, int qty) {
    int index = order.indexWhere((item) => item.id == product.id);

    if (index > -1) {
      order[index].quantity = order[index].quantity! + qty;
    } else {
      order.add(
        product,
      );
    }

    totalAmounts(order, shippingAmount, discountAmount);
    notifyListeners();
  }

  orderRemoveCart(Order cart) {
    int index = order.indexWhere((item) => item.id == cart.id);

    order.removeAt(index);
    notifyListeners();
  }

  updateTotalAmount(double shippingAmount, double discountAmount) {
    finalAmount = totalAmount;
    finalAmount = finalAmount + (shippingAmount - discountAmount);
  }

  totalAmounts(List<Order> list, double shippingAmount, double discountAmount) {
    totalVatAmount = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.vatAmount!));
    totalTaxAmount = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.taxAmount!));
    total = list.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    additionalRowAmount = additional.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity! * element.price!));
    totalAmount = total + totalTaxAmount + totalVatAmount + additionalRowAmount;
    finalAmount = totalAmount;
    updateTotalAmount(shippingAmount, discountAmount);
    notifyListeners();
  }
}

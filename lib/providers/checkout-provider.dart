import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/local_storage.dart';
import 'package:flutter/material.dart';

class CheckOutProvider extends ChangeNotifier {
  List<Invoice> storage = [];
  int? count;

  addCart(Invoice product, int qty) async {
    Invoice? duplicate;

    try {
      duplicate = await LocalStorage().findOne(product.id.toString());
    } catch (err) {
      debugPrint(err.toString());
    }

    if (duplicate != null) {
      product.quantity == product.quantity! + duplicate.quantity!;
    }

    try {
      await LocalStorage().removeWhere(duplicate!.id.toString());
    } catch (err) {
      debugPrint("# # # # # # # # # # # # # # # # # # # # ");
      debugPrint(err.toString());
      debugPrint("# # # # # # # # # # # # # # # # # # # # ");
    }

    // await LocalStorage().set(product);
    await getStorageData();

    notifyListeners();
  }

  getStorageData() async {
    storage = await LocalStorage().findAll();
    int qty = 0;
    for (var element in storage) {
      qty += int.parse(element.quantity.toString());
    }
    count = qty;
    notifyListeners();
  }
}

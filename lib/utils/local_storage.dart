import 'dart:convert';
import 'package:dehub/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String storageName = "CHECKOUT";

  // set(Invoice data) async {
  //   List<Invoice> datas = [];

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   datas = await findAll();
  //   Invoice save = data;
  //   save.unitVariantId = data.id;
  //   datas.add(save);

  //   prefs.setString(storageName, jsonEncode(datas));
  // }

  Future<List<Invoice>> findAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? checkout = prefs.getString("CHECKOUT");

    List<Invoice> data = [];
    List<dynamic> valueMap;

    try {
      valueMap = jsonDecode(checkout!);
      data = valueMap.map((item) => Invoice.fromJson(item)).toList();
    } catch (err) {
      debugPrint(err.toString());
    }
    return data;
  }

  createAll(List<Invoice> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(storageName, jsonEncode(data));
  }

  quantity(String id, String type) async {
    List<Invoice> products = await findAll();

    Invoice product = products.firstWhere((item) => item.id == id);
    int index = products.indexWhere((item) => item.id == id);

    switch (type) {
      case "INCREMENT":
        {
          product.quantity == product.quantity! + 1;
        }
        break;
      case "DECREMENT":
        {
          if (product.quantity! < 2) {
            products.removeWhere((item) => item.id == id);
          } else {
            product.quantity == product.quantity! - 1;
          }
        }
        break;
      default:
    }
    if (product.quantity! > 0) products[index] = product;
    createAll(products);
  }

  Future<Invoice> findOne(String id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Invoice>? products = await findAll();
    return products.firstWhere((item) => item.id == id);
  }

  removeWhere(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Invoice>? products = await findAll();
    products.removeWhere((item) => item.id == id);
    prefs.setString(storageName, jsonEncode(products));
  }

  Future<int> findIndex(String id) async {
    List<Invoice>? products = await findAll();
    return products.indexWhere((item) => item.id == id);
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(storageName);
  }

  addCard(Invoice product, List<Invoice> inventory) async {
    Invoice? duplicate;
    try {
      duplicate = inventory.firstWhere((element) => element.id == product.id);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (duplicate != null) {
      product.quantity! + duplicate.quantity!;
    }

    try {
      inventory.removeWhere((element) => element.id == duplicate!.id);
    } catch (e) {
      debugPrint(e.toString());
    }

    return product;
  }
}

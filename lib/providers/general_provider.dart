import 'package:dehub/api/finance_api.dart';
import 'package:dehub/api/general_api.dart';
import 'package:dehub/models/general.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  General general = General();
  General businessGeneral = General();
  General orderGeneral = General();
  General paymentGeneral = General();
  General financeGeneral = General();
  General inventoryGeneral = General();
  General invoiceGeneral = General();
  General partnerGeneral = General();
  General userGeneral = General();

  userInit(bool handler) async {
    userGeneral = await GeneralApi().userInit(handler);
    notifyListeners();
  }

  init(bool handler) async {
    general = await GeneralApi().init(handler);
    notifyListeners();
  }

  invoiceInit(bool handler) async {
    invoiceGeneral = await GeneralApi().invoiceInit(handler);
  }

  businessInit(bool handler) async {
    businessGeneral = await GeneralApi().businessInit(handler);
    notifyListeners();
  }

  orderInit(bool handler) async {
    orderGeneral = await GeneralApi().orderInit(handler);
    notifyListeners();
  }

  paymentInit(bool handler) async {
    paymentGeneral = await GeneralApi().paymentInit(handler);
    notifyListeners();
  }

  inventoryInit(bool handler) async {
    inventoryGeneral = await GeneralApi().inventoryInit(handler);
    notifyListeners();
  }

  financeInit(String host, bool handler) async {
    financeGeneral = await FinanceApi().init(host, handler);
    notifyListeners();
  }

  partnerInit(bool handler) async {
    partnerGeneral = await GeneralApi().partnerInit(handler);
    notifyListeners();
  }
}

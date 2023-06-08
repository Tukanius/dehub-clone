import 'package:dehub/api/general_api.dart';
import 'package:dehub/models/general.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  General general = General();
  General businessGeneral = General();

  init(bool handler) async {
    general = await GeneralApi().init(handler);
    notifyListeners();
  }

  businessInit(bool handler) async {
    print('BUSINESS-GENERAL');
    try {
      businessGeneral = await GeneralApi().businessInit(handler);
    } catch (e) {
      print('===============ERROR=============');
      print(e.toString());
      print('===============ERROR=============');
    }
    print(businessGeneral.toJson());
    print('BUSINESS-GENERAL');
    notifyListeners();
  }
}

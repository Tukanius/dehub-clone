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
    businessGeneral = await GeneralApi().businessInit(handler);
    notifyListeners();
  }
}

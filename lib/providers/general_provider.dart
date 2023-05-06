import 'package:dehub/api/general_api.dart';
import 'package:dehub/models/general.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  General general = General();

  init(bool handler) async {
    general = await GeneralApi().init(handler);
    print("general.paymentMethod!.length==================");
    print(general.paymentMethod!.map((e) => e.code));
    print("general.paymentMethod!.length==================");
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  loading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

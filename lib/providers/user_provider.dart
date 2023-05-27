import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final DefaultCacheManager cacheManager = DefaultCacheManager();
  User user = User();
  Partner partnerUser = Partner();
  User businessUser = User();

  me(bool handler) async {
    user = await AuthApi().me(handler);
    notifyListeners();
  }

  partnerMe(bool handler) async {
    print('===================PARTNERME==================');
    partnerUser = await AuthApi().partnerMe(handler);
    print('===================PARTNERME==================');
    notifyListeners();
  }

  businessMe(bool handler) async {
    businessUser = await AuthApi().businessMe(handler);
    notifyListeners();
  }

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    notifyListeners();
  }

  setAccessToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("ACCESS_TOKEN", token);
  }

  clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("ACCESS_TOKEN");
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("ACCESS_TOKEN");

    return token;
  }

  logout() async {
    user = User();
    clearAccessToken();
  }
}

import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/finance.dart';
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
  User invoiceMe = User();
  User orderMe = User();
  User paymentMe = User();
  User inventoryMe = User();
  Finance financeUser = Finance();

  financeMe() async {
    financeUser = await FinanceApi().financeMe();
    notifyListeners();
  }

  financeSetToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("FINANCE_TOKEN", token);
  }

  financeLogin(Finance data) async {
    financeUser = await FinanceApi().financeLogin(data);
    financeSetToken(financeUser.accessToken);
    notifyListeners();
  }

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    notifyListeners();
  }

  me(bool handler) async {
    user = await AuthApi().me(handler);
    notifyListeners();
  }

  invoice(bool handler) async {
    invoiceMe = await AuthApi().invoiceMe(handler);
    notifyListeners();
  }

  order(bool handler) async {
    orderMe = await AuthApi().orderMe(handler);
    notifyListeners();
  }

  payment(bool handler) async {
    paymentMe = await AuthApi().paymentMe(handler);
    notifyListeners();
  }

  inventory(bool handler) async {
    inventoryMe = await AuthApi().inventoryMe(handler);
    notifyListeners();
  }

  partnerMe(bool handler) async {
    partnerUser = await AuthApi().partnerMe(handler);
    notifyListeners();
  }

  businessMe(bool handler) async {
    businessUser = await AuthApi().businessMe(handler);
    notifyListeners();
  }

  mailOtp(User data) async {
    User res = await PartnerApi().mailOtp(data);
    await setAccessToken(res.accessToken);
    return res;
  }

  phoneOtp(User data) async {
    user = await PartnerApi().phoneOtp(data);
    await setAccessToken(user.accessToken);
    notifyListeners();
  }

  setAccessToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("ACCESS_TOKEN", token);
  }

  clearFinanceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("FINANCE_TOKEN");
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

  static Future<String?> financeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("FINANCE_TOKEN");

    return token;
  }

  financeLogout() async {
    financeUser = Finance();
    await FinanceApi().logout();
    clearFinanceToken();
  }

  logout() async {
    user = User();
    await AuthApi().logout();
    clearAccessToken();
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("EMAIL");
    return email;
  }

  Future<String?> getCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("CODE");
    return username;
  }

  setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("EMAIL", email);
  }

  setCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("CODE", code);
  }
}

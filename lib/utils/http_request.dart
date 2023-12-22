import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
// import 'package:dehub/src/auth/no_internet/no_internet_screen.dart';
// import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'http_handler.dart';
import '../main.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dehub/src/auth/login_page.dart';

class HttpRequest {
  static const host = 'http://dev-de-dehub.zto.mn/2fa';

  static const partnerHost = 'http://dev-de-partner.zto.mn/prt';

  static const invoiceHost = 'http://dev-de-invoice.zto.mn/inv';

  static const businessHost = 'http://dev-de-network.zto.mn/biz';

  static const inventoryHost = 'http://dev-de-inventory.zto.mn/erp';

  static const orderHost = 'http://dev-de-order.zto.mn/ord';

  static const paymentHost = 'http://dev-de-payment.zto.mn/pay';

  static const s3host = 'http://dev-de-dehub.zto.mn/s3';

  static const media = 'http://dev-de-dehub.zto.mn/mdi';

  static const financeHost = 'http://dev-de-fi.zto.mn';

  static const version = '/app';

  Dio dio = Dio();

  Future<dynamic> request(
      String api, String method, dynamic data, String? type, bool isVersionTrue,
      {bool handler = true, bool approve = false}) async {
    Response? response;
    final String uri;

    if (type == "PARTNER") {
      if (isVersionTrue == false) {
        uri = '$partnerHost$api';
      } else
        uri = '$partnerHost$version$api';
    } else if (type == "INVOICE") {
      uri = '$invoiceHost$version$api';
    } else if (type == "BUSINESS") {
      uri = '$businessHost$version$api';
    } else if (type == "INVENTORY") {
      uri = '$inventoryHost$version$api';
    } else if (type == "ORDER") {
      uri = "$orderHost$version$api";
    } else if (type == "PAYMENT") {
      uri = "$paymentHost$version$api";
    } else if (type == "MEDIA") {
      uri = "$media$api";
    } else if (type == "FINANCE") {
      uri = "$financeHost$version$api";
    } else {
      uri = '$host$version$api';
    }

    debugPrint(uri);

    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++');
    debugPrint('handler: ' + handler.toString() + ", " + uri);
    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++ ');

    try {
      Directory dir = await getTemporaryDirectory();
      CookieJar cookieJar =
          PersistCookieJar(storage: FileStorage(dir.path), ignoreExpires: true);

      dio.interceptors.add(CookieManager(cookieJar));

      var token = await UserProvider.getAccessToken();
      var deviceToken = "";
      debugPrint('++++++++++++++++++++++token++++++++++++++++++');
      debugPrint(token);
      debugPrint('++++++++++++++++++++++token++++++++++++++++++');

      dio.options.headers = {
        'authorization': 'Bearer $token',
        'device-token': '$deviceToken',
        'device_type': 'MOS',
        'device_imei': 'test-imei',
        'device_info': 'iphone 13'
      };
    } catch (err) {
      debugPrint(err.toString());
    }

    if (method != 'GET') {
      debugPrint('body: $data');
    }
    // final Connectivity _connectivity = Connectivity();
    // ConnectivityResult result = ConnectivityResult.none;

    try {
      switch (method) {
        case 'GET':
          {
            response = await dio.get(uri, queryParameters: data);
            break;
          }
        case 'POST':
          {
            response = await dio.post(uri, data: data);
            break;
          }
        case 'PUT':
          {
            response = await dio.put(uri, data: data);
            break;
          }
        case 'DELETE':
          {
            response = await dio.delete(uri, data: data);
            break;
          }
      }

      return HttpHandler(statusCode: response?.statusCode).handle(response);
    } on DioException catch (ex) {
      // try {
      //   result = await _connectivity.checkConnectivity();
      //   if (result == ConnectivityResult.none) {
      //     locator<NavigationService>()
      //         .pushNamed(routeName: NoInternetScreen.routeName);
      //     return null;
      //   }
      // } on PlatformException catch (e) {
      //   debugPrint(e.toString());
      // }

      if (ex.response?.statusCode == 401) {
        locator<NavigationService>().pushNamed(routeName: LoginPage.routeName);
      }

      HttpHandler? error =
          HttpHandler(statusCode: ex.response?.statusCode).handle(ex.response);

      if (handler == true && error!.message != null) {
        final DialogService dialogService = locator<DialogService>();
        dialogService.showErrorDialog(error.message.toString());
      }

      throw error!;
    }
  }

  Future<dynamic> get(String url, String type, bool isVersionTrue,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'GET', data, type, isVersionTrue,
          handler: handler);
    } catch (e) {
      debugPrint("GET =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> post(String url, String type, bool isVersionTrue,
      {dynamic data, bool handler = true, bool approve = false}) async {
    try {
      return await request(
        url,
        'POST',
        data,
        type,
        isVersionTrue,
        handler: handler,
        approve: approve,
      );
    } catch (e) {
      debugPrint("POST =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> put(String url, String type, bool isVersionTrue,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'PUT', data, type, isVersionTrue,
          handler: handler);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> del(String url, String type, bool isVersionTrue,
      {dynamic data, bool handler = true}) async {
    return await request(url, 'DELETE', data, type, isVersionTrue,
        handler: handler);
  }
}

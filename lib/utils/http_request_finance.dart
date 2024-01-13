import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/no_internet/no_internet_screen.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'http_handler.dart';
import '../main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HttpRequestFinance {
  static const version = '/app';

  Dio dio = Dio();

  Future<dynamic> request(String host, String api, String method, dynamic data,
      {bool handler = true, bool approve = false}) async {
    Response? response;
    final String uri;

    uri = '$host$version$api';

    debugPrint(uri);

    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++');
    debugPrint('handler: ' + handler.toString() + ", " + uri);
    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++ ');

    if (host == 'http://dev-de-fi-bogd.zto.mn') {
      try {
        Directory dir = await getTemporaryDirectory();
        CookieJar cookieJar = PersistCookieJar(
            storage: FileStorage(dir.path), ignoreExpires: true);

        dio.interceptors.add(CookieManager(cookieJar));

        var token = await UserProvider.bogdToken();
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
    }

    if (host == "http://dev-de-fi-golomt.zto.mn") {
      try {
        Directory dir = await getTemporaryDirectory();
        CookieJar cookieJar = PersistCookieJar(
            storage: FileStorage(dir.path), ignoreExpires: true);

        dio.interceptors.add(CookieManager(cookieJar));

        var token = await UserProvider.golomtToken();
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
    }

    if (host == "http://dev-de-fi.zto.mn") {
      try {
        Directory dir = await getTemporaryDirectory();
        CookieJar cookieJar = PersistCookieJar(
            storage: FileStorage(dir.path), ignoreExpires: true);

        dio.interceptors.add(CookieManager(cookieJar));

        var token = await UserProvider.generalToken();
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
    }

    if (method != 'GET') {
      debugPrint('body: $data');
    }
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult result = ConnectivityResult.none;

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
      try {
        result = await _connectivity.checkConnectivity();
        if (result == ConnectivityResult.none) {
          locator<NavigationService>()
              .pushNamed(routeName: NoInternetScreen.routeName);
          return null;
        }
      } on PlatformException catch (e) {
        debugPrint(e.toString());
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

  Future<dynamic> get(String host, String url,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(host, url, 'GET', data, handler: handler);
    } catch (e) {
      debugPrint("GET =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> post(String host, String url,
      {dynamic data, bool handler = true, bool approve = false}) async {
    try {
      return await request(
        host,
        url,
        'POST',
        data,
        handler: handler,
        approve: approve,
      );
    } catch (e) {
      debugPrint("POST =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> put(String host, String url,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(host, url, 'PUT', data, handler: handler);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> del(String host, String url,
      {dynamic data, bool handler = true}) async {
    return await request(host, url, 'DELETE', data, handler: handler);
  }
}

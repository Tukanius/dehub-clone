// import 'package:dehub/main.dart';
// import 'package:dehub/src/auth/login_page.dart';
// import 'package:dehub/services/navigation.dart';
import 'package:flutter/cupertino.dart';

class HttpHandler {
  int? statusCode;
  String? message;
  String? code;

  HttpHandler({this.statusCode, this.message, this.code});

  parseMessage(dynamic data) {
    String? message;

    // debugPrint("% % % % % % % % % % % % % % % % % % % % % % % % % % % % %");
    // debugPrint(data.runtimeType == Map<String, dynamic>().runtimeType);
    // debugPrint("% % % % % % % % % % % % % % % % % % % % % % % % % % % % %");

    if (data.runtimeType == <String, dynamic>{}.runtimeType) {
      Map<String, dynamic> json = data as Map<String, dynamic>;

      message = json['message'].toString();
    } else {
      message = data as String;
    }

    return message;
  }

  handle(response) {
    debugPrint(
        '+++++++++++++++++++++++++API HANDLER++++++++++++++++++++++++++');
    debugPrint(
        'HttpHandler: $response , $statusCode, dataType: ${response?.data?.runtimeType}');
    debugPrint(
        '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    dynamic data = <String, dynamic>{};

    if (response?.data?.runtimeType.toString() != "".runtimeType.toString()) {
      data = response.data;
    }

    switch (statusCode) {
      case 200:
      case 304:
        return data;
      // case 401:
      //   locator<NavigationService>().pushNamed(routeName: LoginPage.routeName);
      //   break;
      default:
        HttpHandler error = HttpHandler(
            statusCode: statusCode,
            code: data['code'] as String?,
            message: data['message'] as String?);

        return error;
    }
  }
}

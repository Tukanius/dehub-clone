import 'dart:async';

import 'package:dehub/utils/http_request.dart';
import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res =
        await post('/auth/login', "AUTH", data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  me(bool handler) async {
    var res = await get('/auth/me', "AUTH", handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<User> partnerMe(bool handler) async {
    var res = await get('/auth/me', "PARTNER", handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }
}

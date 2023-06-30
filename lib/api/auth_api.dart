import 'package:dehub/models/partner.dart';
import 'package:dehub/utils/http_request.dart';
import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res = await post('/auth/login', "AUTH", true,
        data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  me(bool handler) async {
    var res = await get('/auth/me', "AUTH", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  partnerMe(bool handler) async {
    var res = await get('/auth/me', "PARTNER", true, handler: handler);
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  checkPin(User data) async {
    Map<String, dynamic> json = {};
    json['pin'] = data.pin;
    var res = await put("/auth/pin/check", "AUTH", true, data: json);
    return res['success'] == true;
  }

  businessMe(bool handler) async {
    var res = await get('auth/me', "BUSINESS", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  createPassword(User data) async {
    var res =
        await post("/auth/password/change", "AUTH", true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }
}

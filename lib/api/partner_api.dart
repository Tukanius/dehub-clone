import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request.dart';

class PartnerApi extends HttpRequest {
  Future<User> register(User data) async {
    var res = await post("/pub/partner", "PARTNER", false, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  mailOtp(User data) async {
    var res = await post("/auth/otp/register_verify", "AUTH", true,
        data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  phoneOtp(User data) async {
    var res = await post('/auth/otp/verify', "AUTH", true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  passwordChange(User data) async {
    var res =
        await post("/auth/password/change", "AUTH", true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  getPhoneOtp(String otpMethod) async {
    var res = await get("/auth/otp?otpMethod=$otpMethod", "AUTH", true);
    return User.fromJson(res as Map<String, dynamic>);
  }
}

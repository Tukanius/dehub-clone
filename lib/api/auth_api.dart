import 'package:image_picker/image_picker.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
    var res = await get('/auth/me', "BUSINESS", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  createPassword(User data) async {
    var res =
        await post("/auth/password/change", "AUTH", true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  invoiceMe(bool handler) async {
    var res = await get('/auth/me', "INVOICE", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  orderMe(bool handler) async {
    var res = await get('/auth/me', "ORDER", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  paymentMe(bool handler) async {
    var res = await get('/auth/me', "PAYMENT", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  inventoryMe(bool handler) async {
    var res = await get('/auth/me', "INVENTORY", true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<User> danVerify() async {
    var res =
        await get('/auth/profile/dan_verify', "AUTH", true, handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  createPin(User data) async {
    Map<String, dynamic> json = {};
    json['pin'] = data.pin;
    var res = await post('/auth/pin', "AUTH", true, data: json);
    return res['success'] == true;
  }

  changePin(User data) async {
    Map<String, dynamic> json = {};
    json['oldPin'] = data.oldPin;
    json['pin'] = data.pin;
    var res = await put('/auth/pin', "AUTH", true, handler: true, data: json);
    return res['success'] == true;
  }

  logout() async {
    var res = await get('/auth/logout', "AUTH", true, handler: false);
    return User.fromJson(res as Map<String, dynamic>);
  }

  avatar(User data) async {
    var res =
        await put('/auth/profile/avatar', "AUTH", true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  upload(XFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var res =
        await post('/media/file/auth/upload', "MEDIA", true, data: formData);

    return User.fromJson(res as Map<String, dynamic>);
  }

  uploadFile(PlatformFile file) async {
    String fileName = file.path!.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path!, filename: fileName),
    });
    var res =
        await post('/media/file/auth/upload', "MEDIA", true, data: formData);

    return User.fromJson(res as Map<String, dynamic>);
  }
}

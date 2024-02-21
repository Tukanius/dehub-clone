import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class PartnerApi extends HttpRequest {
  String type = "PARTNER";
  Future<User> register(User data) async {
    var res = await post("/pub/partner", type, false, data: data.toJson());
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

  Future<Result> branchList(ResultArguments data) async {
    var res = await get('/branch', type, true, data: data.toJson());
    return Result.fromJson(res, Partner.fromJson);
  }

  Future<Result> business(ResultArguments data) async {
    var res = await get('/business', type, true, data: data.toJson());
    return Result.fromJson(res, Partner.fromJson);
  }

  Future<Result> warehouse(ResultArguments data) async {
    var res = await get('/warehouse', type, true, data: data.toJson());
    return Result.fromJson(res, Partner.fromJson);
  }

  upload(XFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var res = await post('/media/file/inventory/upload', "MEDIA", true,
        data: formData);

    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> businessSelect(String businessType) async {
    var res = await get(
        '/business/select?type=$businessType&status=ACTIVE', type, true);
    return Result.fromJson(res, Partner.fromJson);
  }

  Future<Partner> branchCreate(Partner data) async {
    var res = await post('/branch', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> branchUpdate(Partner data, String id) async {
    var res = await put('/branch/$id', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> address(Partner data, String id) async {
    var res = await put('/branch/$id/address', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> warehouseCreate(Partner data) async {
    var res = await post('/warehouse', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> warehouseUpdate(Partner data, String id) async {
    var res = await put('/warehouse/$id', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> profileUpdate(Partner data) async {
    var res = await put('/partner', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  Future<Partner> updateAdmin(Partner data) async {
    var res =
        await put('/partner/update_admin', type, true, data: data.toJson());
    return Partner.fromJson(res as Map<String, dynamic>);
  }

  warehouseDelete(String id) async {
    var res = await del('/warehouse/$id', type, true);
    return res;
  }
}

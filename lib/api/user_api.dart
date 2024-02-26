import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserApi extends HttpRequest {
  String type = "USER";
  Future<Result> usersList(ResultArguments data) async {
    var res = await get('/user', type, true, data: data.toJson());
    return Result.fromJson(res, User.fromJson);
  }

  Future<Result> approvalRule(ResultArguments data) async {
    var res = await get('/approval_rule', type, true, data: data.toJson());
    return Result.fromJson(res, User.fromJson);
  }

  me(bool handler) async {
    var res = await get('/auth/me', type, true, handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  upload(XFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var res =
        await post('/media/file/user/upload', "MEDIA", true, data: formData);

    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<User> userCreate(User data) async {
    var res = await post('/user', type, true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<User> userUpdate(User data, String id) async {
    var res = await put('/user/$id', type, true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  invitationSend(String id) async {
    var res = await put('/user/$id/send', type, true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> roleList(ResultArguments data) async {
    var res = await get('/user/role', type, true, data: data.toJson());
    return Result.fromJson(res, User.fromJson);
  }

  Future<User> roleAdd(User data) async {
    var res = await post('/user/role', type, true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> bankList() async {
    var res = await get('/finance_settings/bank', type, false);
    return Result.fromJson(res, User.fromJson);
  }

  Future<Result> financeRoleList(ResultArguments data) async {
    var res = await get('/finance_settings/finance_role', type, false,
        data: data.toJson());
    return Result.fromJson(res, User.fromJson);
  }
}

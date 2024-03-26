import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dio/dio.dart';

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

  upload(String path) async {
    String fileName = path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: fileName),
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
    var res = await get('/finance_settings/bank', type, true);
    return Result.fromJson(res, User.fromJson);
  }

  Future<Result> financeRoleList(ResultArguments data) async {
    var res = await get('/finance_settings/finance_role', type, true,
        data: data.toJson());
    return Result.fromJson(res, User.fromJson);
  }

  Future<User> financeRoleAssign(User data) async {
    var res = await put('/finance_settings/finance_role/assign', type, true,
        data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<User> financeRoleCreate(User data) async {
    var res = await post('/finance_settings/finance_role', type, true,
        data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> userSelect() async {
    var res =
        await get('/finance_settings/finance_role/user_select', type, true);
    return Result.fromJson(res, User.fromJson);
  }

  Future<Result> bankSelect() async {
    var res =
        await get('/finance_settings/finance_role/bank_select', type, true);
    return Result.fromJson(res, User.fromJson);
  }
}

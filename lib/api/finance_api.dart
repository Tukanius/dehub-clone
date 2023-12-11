// import 'package:dehub/models/finance.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request_finance.dart';

class FinanceApi extends HttpRequestFinance {
  financeMe() async {
    var res = await get('/auth/me', handler: false);
    return User.fromJson(res as Map<String, dynamic>);
  }

  financeLogin(Finance data) async {
    var res = await post('/auth/login', handler: true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> requestList(ResultArguments resultArguments) async {
    var res =
        await get('/request', handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Result> completedList(ResultArguments resultArguments) async {
    var res = await get('/request/completed',
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> requestGet(String id) async {
    var res = await get('/request/$id', handler: true);
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<General> init(bool handler) async {
    var res = await get('/general/init', handler: true);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> repaymentList(ResultArguments resultArguments) async {
    var res =
        await get('/repayment', data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> repaymentGet(String id) async {
    var res = await get('/repayment/$id', handler: true);
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  logout() async {
    await get('/auth/logout');
  }
}

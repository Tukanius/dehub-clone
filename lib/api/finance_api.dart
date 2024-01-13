import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request_finance.dart';

class FinanceApi extends HttpRequestFinance {
  financeMe(String host) async {
    var res = await get(host, '/auth/me', handler: false);
    return User.fromJson(res as Map<String, dynamic>);
  }

  financeLogin(String host, Finance data) async {
    var res =
        await post(host, '/auth/login', handler: true, data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> requestList(
      String host, ResultArguments resultArguments) async {
    var res = await get(host, '/request',
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Result> completedList(
      String host, ResultArguments resultArguments) async {
    var res = await get(host, '/request/completed',
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> requestGet(String host, String id) async {
    var res = await get(host, '/request/$id', handler: true);
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<General> init(String host, bool handler) async {
    var res = await get(host, '/general/init', handler: true);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> repaymentList(
      String host, ResultArguments resultArguments) async {
    var res = await get(host, '/repayment',
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> repaymentGet(String host, String id) async {
    var res = await get(host, '/repayment/$id', handler: true);
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  logout(
    String host,
  ) async {
    await get(host, '/auth/logout');
  }
}

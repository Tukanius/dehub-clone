import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/http_request_finance.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

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

  Future<Result> reminderHistory(String host, ResultArguments data) async {
    var res =
        await get(host, '/repayment/reminder_history', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
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

  Future<Finance> requestGet(String host, String id, String type) async {
    var res = await get(host, '/request/$type/$id', handler: true);
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<General> init(String host, bool handler) async {
    var res = await get(host, '/general/init', handler: handler);
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

  Future<Result> financeableList(String host, ResultArguments data) async {
    var res = await get(host, '/financeable', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Result> programList(String host, ResultArguments data) async {
    var res = await get(host, '/financeable/program', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> financeableLbfGet(
      String host, String id, String programId) async {
    var res = await get(host, '/financeable_lbf/$id/program/$programId');
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> financeableScfGet(
      String host, String id, String programId) async {
    var res = await get(host, '/financeable_scf/$id/program/$programId');
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> createLbf(String host, Finance data) async {
    var res = await post(host, '/request/lbf', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> buyerLedCreate(String host, Finance data) async {
    var res = await post(host, '/request/buyer_led', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> supplierLedCreate(String host, Finance data) async {
    var res = await post(host, '/request/supplier_led', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  uploadFile(String host, PlatformFile file) async {
    String fileName = file.path!.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path!, filename: fileName),
    });
    var res = await post(host, '/media/file/finance/upload', data: formData);
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> repaymentHistory(String host, ResultArguments data) async {
    var res = await get(host, '/repayment/history', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Result> compromiseList(String host, ResultArguments data) async {
    var res = await get(host, '/repayment/compromise', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> compromiseCreate(String host, Finance data, String id) async {
    var res =
        await post(host, '/repayment/$id/compromise', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> pay(String host, Finance data, String id) async {
    var res = await put(host, '/repayment/$id/pay', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> limitUsage(String host, ResultArguments data) async {
    var res = await get(host, '/limit_usage', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Result> settlementList(String host, ResultArguments data) async {
    var res = await get(host, '/settlement', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  logout(String host) async {
    await get(host, '/auth/logout');
  }

  forgot(User data, String host) async {
    var res = await put(host, '/auth/forgot', data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  otpVerify(User data, String host) async {
    var res = await post(host, '/auth/otp/verify', data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> lbfPay(Finance data, String host) async {
    var res = await put(host, '/lbf/account/pay', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  settlementRespond(String host, String id) async {
    var res = await put(host, '/settlement/$id/respond');
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> networkList(String host, ResultArguments data) async {
    var res = await get(host, '/network', data: data.toJson());
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<Finance> setLimit(String host, Finance data) async {
    var res = await put(host, '/network/set_limit', data: data.toJson());
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Finance> dashboardMain(String host, String date, String start,
      String end, String programId) async {
    var res = await get(host,
        '/dashboard?date=$date&startDate=$start&endDate=$end&programId=$programId');
    return Finance.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> programSelect(String host) async {
    var res = await get(host, '/dashboard/program_select');
    return Result.fromJson(res, Finance.fromJson);
  }
}

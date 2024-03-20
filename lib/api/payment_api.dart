import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';

class PaymentApi extends HttpRequest {
  Future<Invoice> pay(Invoice data) async {
    var res = await post('/invoice', "PAYMENT", true,
        handler: true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> bankAccountList(ResultArguments resultArguments) async {
    var res = await get('/bank_account', "PAYMENT", true,
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Payment.fromJson);
  }

  Future<Payment> bankAccountCheck(Payment data) async {
    var res = await post('/bank_account/check', "PAYMENT", true,
        handler: true, data: data.toJson());
    return Payment.fromJson(res as Map<String, dynamic>);
  }

  Future<Payment> addBankAccount(Payment data) async {
    var res = await post('/bank_account', "PAYMENT", true,
        handler: true, data: data.toJson());
    return Payment.fromJson(res as Map<String, dynamic>);
  }

  Future<Payment> bankAccountGet(String id) async {
    var res = await get('/bank_account/$id', "PAYMENT", true, handler: true);
    return Payment.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> transactionList(ResultArguments resultArguments) async {
    var res = await get('/transaction', 'PAYMENT', true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Payment.fromJson);
  }

  Future<Payment> accountStatement(ResultArguments resultArguments) async {
    var res = await get('/transaction/account', "PAYMENT", true,
        data: resultArguments.toJson());
    return Payment.fromJson(res);
  }

  Future<Payment> transactionGet(String id) async {
    var res = await get('/transaction/$id', "PAYMENT", true, handler: true);
    return Payment.fromJson(res as Map<String, dynamic>);
  }

  Future<Payment> dashboard(String startDate, String endDate,
      String structureMonth, String date) async {
    var res = await get(
        '/dashboard/main?startDate=$startDate&endDate=$endDate&structureMonth=$structureMonth&date=$date',
        'PAYMENT',
        true);
    return Payment.fromJson(res as Map<String, dynamic>);
  }

  Future<Payment> bankAccountUpdate(Payment data, String id) async {
    var res =
        await put('/bank_account/$id', "PAYMENT", true, data: data.toJson());
    return Payment.fromJson(res as Map<String, dynamic>);
  }
}

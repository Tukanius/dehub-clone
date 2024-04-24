import 'package:dehub/models/result.dart';
import 'package:dehub/models/invoice.dart';

import '../utils/http_request.dart';

class InvoiceApi extends HttpRequest {
  String type = "INVOICE";
  Future<Result> list(ResultArguments resultArguments) async {
    var res =
        await get('/invoice/sent', type, true, data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Result> listReceived(ResultArguments resultArguments) async {
    var res = await get('/invoice/received', type, true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Invoice> getInvoice(String id) async {
    var res = await get('/invoice/$id', type, true, handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> listClosed(ResultArguments resultArguments) async {
    var res = await get("/invoice/closed", type, true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  pay(String id, Invoice data) async {
    var res = await put(
        '/invoice/$id/pay', data: data.toJson(), type, true, handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> network(String query) async {
    var res =
        await get("/network/select?query=$query", type, true, handler: true);
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> brach(String businessId, String query) async {
    var res = await get(
      "/branch/select?businessId=$businessId&query=$query",
      type,
      true,
    );
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Invoice> createInvoice(Invoice data) async {
    var res =
        await post('/invoice', type, true, data: data.toJson(), handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> updateInvoice(Invoice data, String id) async {
    var res = await put('/invoice/$id', type, true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> networkGet(String id) async {
    var res = await get("/network/$id", type, true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> respond(String id, Invoice data) async {
    var res = await put('/invoice/$id/respond', type, true,
        handler: true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> settlement(ResultArguments resultArguments) async {
    var res = await get('/network_settlement/network', type, true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Result> networkSettlementInvoice(
      ResultArguments resultArguments) async {
    var res = await get('/network_settlement/invoice', type, true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Result> settlementHistory(ResultArguments resultArguments) async {
    var res = await get('/network_settlement/invoice/history', type, true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> invoiceHistory(ResultArguments data) async {
    var res = await get('/invoice/history', type, true, data: data.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> settlementSent(ResultArguments data) async {
    var res = await get('/settlement/sent', type, true, data: data.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> settlementReceived(ResultArguments data) async {
    var res =
        await get('/settlement/received', type, true, data: data.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Invoice> settlementDetail(String id) async {
    var res = await get('/settlement/$id', type, true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> settlementInvoice(ResultArguments data) async {
    var res = await get('/settlement/invoice', type, true, data: data.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  settlementSend(String id) async {
    var res = await put('/settlement/$id/send', type, true);
    return res;
  }

  settlementRespond(String id) async {
    var res = await put('/settlement/$id/respond', type, true);
    return res;
  }

  Future<Result> businessSelect() async {
    var res = await get('/invoice/history/business_select', type, true);
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> historyInvoiceList(ResultArguments data) async {
    var res = await get('/invoice/history/invoice_list', type, true,
        data: data.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Invoice> historyCreate(Invoice data) async {
    var res = await post('/invoice/history', type, true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> dashboard(
      String date, String startDate, String endDate) async {
    var res = await get(
        '/dashboard/main?date=$date&confirmedStartDate=$startDate&confirmedEndDate=$endDate',
        type,
        true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  pdf(String id) async {
    var res = await get('/invoice/$id/pdf', type, true);
    return res as String;
  }
}

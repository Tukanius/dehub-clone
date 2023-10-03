import 'package:dehub/models/result.dart';
import 'package:dehub/models/invoice.dart';

import '../utils/http_request.dart';

class InvoiceApi extends HttpRequest {
  Future<Result> list(ResultArguments resultArguments) async {
    var res = await get('/invoice/sent', "INVOICE", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Result> listReceived(ResultArguments resultArguments) async {
    var res = await get('/invoice/received', "INVOICE", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Invoice> getInvoice(String id) async {
    var res = await get('/invoice/$id', "INVOICE", true, handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> listClosed(ResultArguments resultArguments) async {
    var res = await get("/invoice/closed", "INVOICE", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  pay(String id, Invoice data) async {
    var res = await put(
        '/invoice/$id/pay',
        data: data.toJson(),
        "INVOICE",
        true,
        handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> network(String query) async {
    var res = await get("/network/select?query=${query}", "INVOICE", true,
        handler: true);
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> brach(String businessId, String query) async {
    var res = await get(
      "/branch/select?businessId=$businessId&query=$query",
      "INVOICE",
      true,
    );
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Invoice> createInvoice(Invoice data) async {
    var res = await post('/invoice', "INVOICE", true,
        data: data.toJson(), handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> networkGet(String id) async {
    var res = await get("/network/$id", 'INVOICE', true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> respond(String id, Invoice data) async {
    var res = await put('/invoice/$id/respond', "INVOICE", true,
        handler: true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }
}

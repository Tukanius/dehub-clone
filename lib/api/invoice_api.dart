import 'package:dehub/models/result.dart';
import 'package:dehub/models/invoice.dart';

import '../utils/http_request.dart';

class InvoiceApi extends HttpRequest {
  Future<Result> list(ResultArguments resultArguments) async {
    var res =
        await get('/invoice/sent', "INVOICE", data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Result> listReceived(ResultArguments resultArguments) async {
    var res = await get('/invoice/received', "INVOICE",
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.$fromJson);
  }

  Future<Invoice> getInvoice(String id) async {
    var res = await get('/invoice/$id', "INVOICE", handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> listClosed(ResultArguments resultArguments) async {
    var res =
        await get("/invoice/closed", "INVOICE", data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  pay(String id, Invoice data) async {
    var res = await put(
        '/invoice/$id/pay', data: data.toJson(), "INVOICE", handler: true);
    print(res);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }
}

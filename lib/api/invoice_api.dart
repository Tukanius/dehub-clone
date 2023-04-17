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
    var res;
    try {
      res = await get('/invoice/$id', "INVOICE", handler: true);
    } catch (e) {
      print("===============res==================");
      print(e.toString());
      print("===============res==================");
    }
    return Invoice.fromJson(res as Map<String, dynamic>);
  }

  Future<Invoice> pay(String id) async {
    var res = await put('invoice/$id/pay', "INVOICE", handler: true);
    return Invoice.fromJson(res as Map<String, dynamic>);
  }
}

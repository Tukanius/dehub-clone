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

  getInvoice(String id) async {
    var res = await get('/invoice/$id', "INVOICE", handler: false);
    print('===============RES===================');
    print(res);
    print('===============RES===================');
    return res;
  }
}

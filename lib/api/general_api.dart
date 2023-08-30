import 'package:dehub/models/general.dart';
import 'package:dehub/utils/http_request.dart';

class GeneralApi extends HttpRequest {
  Future<General> init(bool handler) async {
    var res = await get("/general/init", "INVOICE", true, handler: handler);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<General> businessInit(bool handler) async {
    var res = await get("/general/init", "BUSINESS", true, handler: handler);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<General> orderInit(bool handler) async {
    var res = await get('/general/init', "ORDER", true, handler: handler);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<General> paymentInit(bool handler) async {
    var res = await get('/general/init', "PAYMENT", true, handler: handler);
    return General.fromJson(res as Map<String, dynamic>);
  }

  Future<General> inventoryInit(bool handler) async {
    var res = await get('/general/init', "INVENTORY", true, handler: handler);
    return General.fromJson(res as Map<String, dynamic>);
  }
}

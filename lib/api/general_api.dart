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
}

import 'package:dehub/models/general.dart';
import 'package:dehub/utils/http_request.dart';

class GeneralApi extends HttpRequest {
  Future<General> init(bool handler) async {
    var res = await get("/general/init", "INVOICE", handler: handler);
    print('=====================RES=======================');
    print(res);
    print('=====================RES=======================');
    return General.fromJson(res as Map<String, dynamic>);
  }
}

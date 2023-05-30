import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';

class BusinessApi extends HttpRequest {
  Future<Result> list(ResultArguments resultArguments) async {
    var res = await get('/invitation/received/', "BUSINESS",
        data: resultArguments.toJson());
    print('===================BUSINESSAPI==============');
    print(res);
    print('===================BUSINESSAPI==============');
    return Result.fromJson(res, InvitationReceived.$fromJson);
  }
}

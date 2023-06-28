import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dehub/models/result.dart';

class InventoryApi extends HttpRequest {
  Future<Result> listGoods(ResultArguments resultArguments) async {
    var res = await get("/invoice/variant", "INVENTORY",
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> listProduct(ResultArguments resultArguments) async {
    var res = await get("/goods", "INVENTORY", data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  goodsGet(String id) async {
    var res = await get('/goods/$id', "INVENTORY");
    return InventoryGoods.fromJson(res);
  }
}

import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dehub/models/result.dart';

class InventoryApi extends HttpRequest {
  Future<Result> listGoods(ResultArguments resultArguments) async {
    var res = await get("/invoice/variant", "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> listProduct(ResultArguments resultArguments) async {
    var res =
        await get("/goods", "INVENTORY", true, data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  goodsGet(String id) async {
    var res = await get(
      '/goods/$id',
      "INVENTORY",
      true,
    );
    return InventoryGoods.fromJson(res);
  }

  Future<Result> orderListGoods(ResultArguments resultArguments) async {
    var res =
        await get('/order/variant/select?', "INVENTORY", true, handler: true);
    return Result.fromJson(res, Invoice.fromJson);
  }

  Future<Result> category(String orderType, String businessId) async {
    var res = await get(
        '/order/category?orderType=$orderType&businessId=$businessId',
        "INVENTORY",
        true,
        handler: true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }
}
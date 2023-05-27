import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dehub/models/result.dart';
import 'package:flutter/material.dart';

class InventoryApi extends HttpRequest {
  Future<Result> listGoods(ResultArguments resultArguments) async {
    var res = await get("/goods", "INVENTORY", data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }
}

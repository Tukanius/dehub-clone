import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';

class OrderApi extends HttpRequest {
  Future<Result> networkList(ResultArguments resultArguments) async {
    var res = await get("/network", "ORDER", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> networkGet(String id) async {
    var res = await get('/network/$id', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> variantSelect(
      String? orderType,
      String? businessId,
      String? query,
      String? supplierId,
      String? categoryId,
      String? brandId) async {
    var res = await get(
        '/order/variant/select?orderType=$orderType&businessId=$businessId&query=$query&categoryId=$categoryId&supplierId=$supplierId&brandId=$brandId&limit=',
        "INVENTORY",
        true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Result> branchSelect(
      String? businessId, int? limit, String? query) async {
    var res = await get(
        '/branch/select?businessId=$businessId&query=$query&limit=$limit',
        "ORDER",
        true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> createOrder(Order data) async {
    var res =
        await post('/order', "ORDER", true, data: data.toJson(), handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> orderList(ResultArguments resultArguments) async {
    var res = await get('/order', "ORDER", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> orderGet(String id) async {
    var res = await get('/order/$id', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  respond(String id, Order data) async {
    var res =
        await put('/order/$id/respond', "ORDER", true, data: data.toJson());
    return res;
  }

  review(String id, Order data) async {
    var res = await put('/order/$id/review', "ORDER", true,
        handler: true, data: data.toJson());
    return res;
  }

  Future<Result> pullSheet(ResultArguments resultArguments) async {
    var res = await get('/pull_sheet', "ORDER", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> pullSheetEnd(String id) async {
    var res = await put('/pull_sheet/$id/end', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetPause(String id) async {
    var res = await put('/pull_sheet/$id/pause', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetStart(String id) async {
    var res = await put('/pull_sheet/$id/start', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetProceed(String id) async {
    var res =
        await put('/pull_sheet/$id/proceed', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetGet(String id) async {
    var res = await get('/pull_sheet/$id', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> deliveryNoteList(ResultArguments resultArguments) async {
    var res = await get('/delivery_note', "ORDER", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> lineConfirm(Order data, String id) async {
    var res = await put('/pull_sheet/$id/line_confirm', "ORDER", true,
        handler: true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNoteStart(String id) async {
    var res =
        await put('/delivery_note/$id/start', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }
}

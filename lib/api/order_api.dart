import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dio/dio.dart';

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

  Future<Result> variantSelect(String? orderType, String? businessId,
      String? query, String? categoryId, String? brandId) async {
    var res = await get(
        '/order/variant/select?orderType=$orderType&businessId=$businessId&query=$query&categoryId=$categoryId&brandId=$brandId&limit=',
        "INVENTORY",
        true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Result> branchSelect(String? businessId) async {
    var res = await get(
        '/branch/select?businessId=$businessId&query=&limit=', "ORDER", true);
    return Result.fromJson(res, Order.fromJson);
  }

  createOrder(Order data) async {
    var res = await post('/order', "ORDER", true, data: data.toJson());
    return res;
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
    var res = await get('/delivery_management', "ORDER", true,
        data: resultArguments.toJson(), handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> pullSheetLineConfirm(Order data, String id) async {
    var res = await put('/pull_sheet/$id/line_confirm', "ORDER", true,
        handler: true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNoteStart(String id) async {
    var res = await put('/delivery_management/$id/start', "ORDER", true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> createConversation(Order data) async {
    var res = await post('/delivery_management/conversation', 'ORDER', true,
        data: data.toJson(), handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> conversationList(String id, int limit) async {
    var res = await get(
        '/delivery_management/conversation?deliveryNoteId=$id&limit=$limit',
        "ORDER",
        true,
        handler: true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> deliveryNoteGet(String id) async {
    var res =
        await get('/delivery_management/$id', 'ORDER', true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNotestart(String id) async {
    var res = await put('/delivery_management/$id/start', "ORDER", true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNoteProceed(String id) async {
    var res = await put('/delivery_management/$id/proceed', 'ORDER', true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNotePause(String id) async {
    var res = await put('/delivery_management/$id/pause', 'ORDER', true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNoteEnd(String id) async {
    var res =
        await put('/delivery_management/$id/end', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryNoteLineConfirm(Order data, String id) async {
    var res = await put('/delivery_management/$id/line_confirm', "ORDER", true,
        data: data.toJson(), handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> getPhone(String id, String phone) async {
    var res = await get('/receipt/$id/get_phone?phone=$phone', "ORDER", true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetConfirm(String id) async {
    var res =
        await put('/pull_sheet/$id/confirm', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> receiptGetCode(String id, String phone) async {
    var res = await get('/receipt/$id/get_code?phone=$phone', "ORDER", true,
        handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> receiptConfirm(String id, Order? code) async {
    var res = await put('/receipt/$id/confirm', 'ORDER', true,
        handler: true, data: code?.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> receiptGet(String id) async {
    var res = await get('/receipt/$id', "ORDER", true, handler: true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> pullSheetCreate(Order data) async {
    var res = await post('/pull_sheet', "ORDER", true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> staffSelect(String businessId) async {
    var res = await get('/staff/select?businessId=$businessId', "ORDER", true);
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> update(String id, Order data) async {
    var res = await put('/order/$id', "ORDER", true,
        handler: true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> splitList(ResultArguments data) async {
    var res = await get('/order/split', "ORDER", true, data: data.toJson());
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> splitCreate(Order data, String id) async {
    var res = await put('/order/$id/split', "ORDER", true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> backOrderList(ResultArguments data) async {
    var res = await get('/order/backorder', "ORDER", true, data: data.toJson());
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Result> getLines(Order data) async {
    var res = await put('/order/backorder/get_lines', "ORDER", true,
        data: data.toJson());
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> backorderCreate(Order data) async {
    var res =
        await post('/order/backorder', "ORDER", true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> dropshipList(ResultArguments data) async {
    var res =
        await get('/order/dropshipping', "ORDER", true, data: data.toJson());
    return Result.fromJson(res, Order.fromJson);
  }

  Future<Order> dropshipCreate(Order data) async {
    var res =
        await post('/order/dropshipping', "ORDER", true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> dashboard(String date) async {
    var res =
        await get('/dashboard/main?date=$date&pieFilter=WEEK', "ORDER", true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> upload(String path) async {
    String fileName = path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: fileName),
    });
    var res =
        await post('/media/file/order/upload', "MEDIA", true, data: formData);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  cancel(String id) async {
    var res = await put('/order/$id/cancel', "ORDER", true);
    return res;
  }

  Future<Order> deliveryManagementCreate(Order data) async {
    var res = await post('/delivery_note', "ORDER", true,
        handler: true, data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryManagementAssign(Order data, String id) async {
    var res = await put('/delivery_note/$id/assign', "ORDER", true,
        data: data.toJson());
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Order> deliveryManagementApprove(String id) async {
    var res = await get('/delivery_note/$id/approve', "ORDER", true);
    return Order.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> deliveryManagementList(ResultArguments resultArguments) async {
    var res = await get('/delivery_note', "ORDER", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, Order.fromJson);
  }
}

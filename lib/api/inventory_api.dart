import 'package:dio/dio.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dehub/models/result.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<Result> storeGoods(ResultArguments data) async {
    var res = await get('/store/goods', 'INVENTORY', true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> suppliers(ResultArguments data) async {
    var res =
        await get('/store/supplier', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> fetch(
      {required String id, required InventoryGoods data}) async {
    var res = await post('/store/goods/$id/fetch', 'INVENTORY', true,
        data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  goodsGet(String id) async {
    var res = await get('/goods/$id', "INVENTORY", true);
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

  Future<Result> brandList() async {
    var res = await get('/brand/select', 'INVENTORY', true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> brandCreate(InventoryGoods data) async {
    var res = await post('/brand', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> brandDelete(String id) async {
    var res = await del('/brand/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> brandUpdate(String id, InventoryGoods data) async {
    var res = await put('/brand/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> supplierList() async {
    var res = await get('/supplier/select', 'INVENTORY', true, handler: true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> supplierCreate(InventoryGoods data) async {
    var res = await post('/supplier', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> supplierDelete(String id) async {
    var res = await del('/supplier/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> supplierUpdate(String id, InventoryGoods data) async {
    var res =
        await put('/supplier/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> manufacturerList() async {
    var res = await get('/manufacturer/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> manufacturerCreate(InventoryGoods data) async {
    var res =
        await post('/manufacturer', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> manufacturerDelete(String id) async {
    var res = await del('/manufacturer/$id', 'INVENTORY', true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> manufacturerUpdate(
      String id, InventoryGoods data) async {
    var res =
        await put('/manufacturer/$id', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> distributorList() async {
    var res = await get('/distributor/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> distributorCreate(InventoryGoods data) async {
    var res =
        await post('/distributor', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> distributorUpdate(
      String id, InventoryGoods data) async {
    var res =
        await put('/distributor/$id', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> distributorDelete(String id) async {
    var res = await del('/distributor/$id', 'INVENTORY', true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> itemTypeList(bool isGoods) async {
    var res =
        await get('/item_type/select?isGoods=$isGoods', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> itemTypeCreate(InventoryGoods data) async {
    var res = await post('/item_type', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> itemTypeDelete(String id) async {
    var res = await del('/item_type/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> itemTypeUpdate(String id, InventoryGoods data) async {
    var res =
        await put('/item_type/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> categoryList(
      String type, String itemTypeId, String parentId) async {
    var res = await get(
        '/category/select?type=$type&itemTypeId=$itemTypeId&parentId=$parentId&query&isGoods&isService&limit',
        "INVENTORY",
        true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> categoryCreate(InventoryGoods data) async {
    var res = await post('/category', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> categoryDelete(String id) async {
    var res = await del('/category/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> categoryUpdate(String id, InventoryGoods data) async {
    var res =
        await put('/category/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> tagList() async {
    var res = await get('/tag/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> tagCreate(InventoryGoods data) async {
    var res = post('/tag', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  upload(XFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var res = await post('/media/file/inventory/upload', "MEDIA", true,
        data: formData);

    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> unitList() async {
    var res = await get('/unit/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> unitCreate(InventoryGoods data) async {
    var res = await post('/unit', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> unitDelete(String id) async {
    var res = await del('/unit/$id', 'INVENTORY', true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> unitUpdate(String id, InventoryGoods data) async {
    var res = await put('/unit/$id', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> optionList(bool isGoods, bool isService) async {
    var res = await get('/option/select?isGoods=$isGoods&isService=$isService',
        "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> optionCreate(InventoryGoods data) async {
    var res = await post('/option', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> optionDelete(String id) async {
    var res = await del('/option/$id', 'INVENTORY', true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> optionUpdate(String id, InventoryGoods data) async {
    var res = await put('/option/$id', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> goodsCreate(InventoryGoods data) async {
    var res = await post('/goods', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> sectionSelect() async {
    var res = await get('/section/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> additionalInfo(InventoryGoods data, String id) async {
    var res = await put('/goods/$id/additional_info', 'INVENTORY', true,
        data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> updateVariant(InventoryGoods data, String id) async {
    var res =
        await put('/goods/$id/variant', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }
}

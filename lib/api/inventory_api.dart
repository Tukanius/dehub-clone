import 'package:dehub/models/finance.dart';
import 'package:dio/dio.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/http_request.dart';
import 'package:dehub/models/result.dart';

class InventoryApi extends HttpRequest {
  Future<Result> listGoods(String businessId) async {
    var res = await get(
        "/invoice/variant/select?businessId=$businessId", "INVENTORY", true);
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

  Future<Result> manufacturerSelect() async {
    var res = await get('/manufacturer/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> manufacturerList(ResultArguments resultArguments) async {
    var res = await get('/manufacturer', "INVENTORY", true,
        data: resultArguments.toJson());
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

  Future<Result> distributorSelect() async {
    var res = await get('/distributor/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> distributorList(ResultArguments resultArguments) async {
    var res = await get('/distributor', "INVENTORY", true,
        data: resultArguments.toJson());
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

  Future<Result> itemTypeSelect(bool isGoods) async {
    var res =
        await get('/item_type/select?isGoods=$isGoods', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> itemTypeList(ResultArguments resultArguments) async {
    var res = await get('/item_type', "INVENTORY", true,
        data: resultArguments.toJson());
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

  Future<Result> categorySelect(
      String type, String itemTypeId, String parentId) async {
    var res = await get(
        '/category/select?type=$type&itemTypeId=$itemTypeId&parentId=$parentId&query&isGoods&isService&limit',
        "INVENTORY",
        true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> categoryList(ResultArguments resultArguments) async {
    var res = await get('/category', "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> categoryCreate(InventoryGoods data) async {
    var res = await post('/category', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> subCategoryCreate(InventoryGoods data) async {
    var res =
        await post('/category/sub', "INVENTORY", true, data: data.toJson());
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

  Future<Result> tagSelect() async {
    var res = await get('/tag/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> tagList(ResultArguments data) async {
    var res = await get('/tag', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> tagCreate(InventoryGoods data) async {
    var res = post('/tag', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> tagUpdate(String id, InventoryGoods data) async {
    var res = await put('/tag/$id', 'INVENTORY', true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> tagDelete(String id) async {
    var res = await del('/tag/$id', 'INVENTORY', true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  upload(String path) async {
    String fileName = path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: fileName),
    });
    var res = await post('/media/file/inventory/upload', "MEDIA", true,
        data: formData);

    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> unitSelect() async {
    var res = await get('/unit/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> unitList(ResultArguments resultArguments) async {
    var res =
        await get('/unit', "INVENTORY", true, data: resultArguments.toJson());
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

  Future<Result> optionSelect(bool isGoods, bool isService) async {
    var res = await get('/option/select?isGoods=$isGoods&isService=$isService',
        "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> optionList(ResultArguments resultArguments) async {
    var res = get('/option', "INVENTORY", true, data: resultArguments.toJson());
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

  Future<InventoryGoods> sectionCreate(InventoryGoods data) async {
    var res = await post('/section', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
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

  price(InventoryGoods data) async {
    var res = put('/goods/price', "INVENTORY", true, data: data.toJson());
    return res;
  }

  Future<Result> warehouseSelect() async {
    var res = await get('/goods/warehouse/select', 'INVENTORY', true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> merchStaffSelect() async {
    var res = await get('/goods/warehouse/merch_staff', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> warehouseBuyer() async {
    var res = await get('/goods/warehouse/buyer', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> warehousePartner(String id) async {
    var res = await get(
        '/goods/warehouse/partner?buyerBusinessId=$id', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> warehouseSupplier(
      {required String id, required String partnerId}) async {
    var res = await get(
        '/goods/warehouse/supplier?buyerBusinessId=$id&partnerId=$partnerId',
        "INVENTORY",
        true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> setWarehouse(InventoryGoods data) async {
    var res = await put('/goods/warehouse', "INVENTORY", true,
        data: data.toJson(), handler: true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> statusChange(InventoryGoods data, String id) async {
    var res = await put('/goods/variant/$id/status_change', "INVENTORY", true,
        data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> addVariant(InventoryGoods data) async {
    var res =
        await post('/goods/variant', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> variant(InventoryGoods data) async {
    var res =
        await post('/goods/variant', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> variantSelect(String id) async {
    var res = await get(
        '/stock/adjustment/variant_select?warehouseId=$id', 'INVENTORY', true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> packageTypeList(ResultArguments resultArguments) async {
    var res = await get('/package_type', "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> packageTypeUpdate(
      String id, InventoryGoods data) async {
    var res =
        await put('/package_type/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> packageTypeDelete(String id) async {
    var res = await del('/package_type/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> packageTypeCreate(InventoryGoods data) async {
    var res =
        await post('/package_type', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> deliveryTypeList(ResultArguments resultArguments) async {
    var res = await get('/delivery_type', "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> deliveryTypeCreate(InventoryGoods data) async {
    var res =
        await post('/delivery_type', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> deliveryTypeUpdate(
      String id, InventoryGoods data) async {
    var res =
        await put('/delivery_type/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> deliveryTypeDelete(String id) async {
    var res = await del('/delivery_type/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> inactiveTypeList(ResultArguments resultArguments) async {
    var res = await get('/inactive_type', "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> inactiveTypeUpdate(
      String id, InventoryGoods data) async {
    var res =
        await put('/inactive_type/$id', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> inactiveTypeDel(String id) async {
    var res = await del('/inactive_type/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> inactiveTypeCreate(InventoryGoods data) async {
    var res =
        await post('/inactive_type', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> inactiveTypeSelect() async {
    var res = await get('/inactive_type/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> adjustmentNoteList(ResultArguments resultArguments) async {
    var res = await get('/adjustment_note', "INVENTORY", true,
        data: resultArguments.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> adjustmentNoteSelect() async {
    var res = await get('/adjustment_note/select', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> adjustmentNoteCreate(InventoryGoods data) async {
    var res =
        await post('/adjustment_note', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> adjustmentNoteUpdate(
      String id, InventoryGoods data) async {
    var res = await put('/adjustment_note/$id', "INVENTORY", true,
        data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> adjustmentNoteDel(String id) async {
    var res = await del('/adjustment_note/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> stockList(ResultArguments data) async {
    var res = await get('/stock', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> adjustmentList(ResultArguments data) async {
    var res =
        await get('/stock/adjustment', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> warehouse() async {
    var res = await get('/warehouse/select', 'INVENTORY', true);
    return Result.fromJson(res, Finance.fromJson);
  }

  Future<InventoryGoods> adjust(InventoryGoods data) async {
    var res = await put('/stock/adjustment/adjust', "INVENTORY", true,
        data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> networkList(ResultArguments data) async {
    var res = await get('/network', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> priceGroupSelect(String type) async {
    var res = await get('/price_group/select?type=$type', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> priceGroupList(ResultArguments data) async {
    var res = await get('/price_group', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> createPriceGroup(InventoryGoods data) async {
    var res =
        await post('/price_group', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> setPrice(InventoryGoods data) async {
    var res =
        await put('/network/set_price', "INVENTORY", true, data: data.toJson());
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> priceGroupGoods(ResultArguments data) async {
    var res =
        await get('/price_group/goods', "INVENTORY", true, data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<Result> priceGroupVariant(String type) async {
    var res =
        await get('/price_group/variant/select?type=$type', "INVENTORY", true);
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> priceGroupGet(String id) async {
    var res = await get('/price_group/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<InventoryGoods> priceGroupVariantGet(String id) async {
    var res = await get('/price_group/goods/variant/$id', "INVENTORY", true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }

  Future<Result> priceGroupVariantHistory(ResultArguments data) async {
    var res = await get('/price_group/goods/variant/history', "INVENTORY", true,
        data: data.toJson());
    return Result.fromJson(res, InventoryGoods.fromJson);
  }

  Future<InventoryGoods> dashboard(
      String date, String rowDate, String startDate, String endDate) async {
    var res = await get(
        '/dashboard/main?date=$date&rowDate=$rowDate&startDate=$startDate&endDate=$endDate',
        "INVENTORY",
        true);
    return InventoryGoods.fromJson(res as Map<String, dynamic>);
  }
}

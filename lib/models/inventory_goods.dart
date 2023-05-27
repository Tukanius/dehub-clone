part '../parts/inventory_goods.dart';

class InventoryGoods {
  int? count;
  List<InventoryGoods>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? type;
  String? itemStatus;
  String? refCode;
  String? skuCode;
  String? barCode;
  String? erpCode;
  String? nameMon;
  String? nameEng;
  String? nameBill;
  String? nameWeb;
  String? nameApp;
  String? deliveryTypeId;
  String? supplierId;
  String? brandId;
  String? manufacturerId;
  String? originCountryId;
  String? importerCountryId;
  String? distributorId;
  String? itemTypeId;
  String? classificationId;
  String? subClassificationId;
  String? categoryId;
  String? subCategoryId;
  String? tagId;
  String? description;
  bool? hasVariant;
  bool? hasUnit;
  String? departmentUnitId;
  String? departmentSubUnitId;
  String? unitId;
  double? height;
  double? width;
  double? length;
  double? weight;
  double? space;
  String? weightLabel;
  String? spaceLabel;
  bool? returnAllow;
  String? returnType;
  String? image;
  String? packageTypeId;
  bool? isCompleted;
  bool? isFetch;
  InventoryGoods? catergory;
  String? parentId;
  String? regUserId;
  String? name;
  double? fieldCount;
  bool? isPublic;
  bool? isGoods;
  bool? isService;
  bool? isDehub;
  InventoryGoods? unit;
  double? quantity;

  InventoryGoods({
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.type,
    this.itemStatus,
    this.refCode,
    this.skuCode,
    this.barCode,
    this.erpCode,
    this.nameMon,
    this.nameEng,
    this.nameBill,
    this.nameWeb,
    this.nameApp,
    this.deliveryTypeId,
    this.supplierId,
    this.brandId,
    this.manufacturerId,
    this.originCountryId,
    this.importerCountryId,
    this.distributorId,
    this.itemTypeId,
    this.classificationId,
    this.subClassificationId,
    this.categoryId,
    this.subCategoryId,
    this.tagId,
    this.description,
    this.hasVariant,
    this.hasUnit,
    this.departmentUnitId,
    this.departmentSubUnitId,
    this.unitId,
    this.height,
    this.width,
    this.length,
    this.weight,
    this.space,
    this.weightLabel,
    this.spaceLabel,
    this.returnAllow,
    this.returnType,
    this.image,
    this.packageTypeId,
    this.isCompleted,
    this.isFetch,
    this.catergory,
    this.parentId,
    this.regUserId,
    this.name,
    this.fieldCount,
    this.isPublic,
    this.isGoods,
    this.isService,
    this.isDehub,
    this.unit,
    this.quantity,
  });

  static $fromJson(Map<String, dynamic> json) => _$InventoryGoodsFromJson(json);

  factory InventoryGoods.fromJson(Map<String, dynamic> json) =>
      _$InventoryGoodsFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryGoodsToJson(this);
}

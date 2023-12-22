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
  bool? reOrder;
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
  String? returnTypeId;
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
  String? text;
  String? url;
  double? minBalance;
  double? maxBalance;
  double? minOrderNum;
  double? reOrderNum;
  double? reOrderMinNum;
  InventoryGoods? brand;
  InventoryGoods? supplier;
  InventoryGoods? manufacturer;
  String? originCountry;
  String? importerCountry;
  InventoryGoods? distributor;
  InventoryGoods? itemType;
  InventoryGoods? classification;
  InventoryGoods? subClassification;
  InventoryGoods? category;
  InventoryGoods? subCategory;
  InventoryGoods? tag;
  InventoryGoods? deliveryType;
  InventoryGoods? packageType;
  List<InventoryGoods>? coverImages;
  List<String>? detailImages;
  List<InventoryGoods>? sections;
  List<String>? sectionIds;
  List<InventoryGoods>? fields;
  List<InventoryGoods>? itemFieldValues;
  List<InventoryGoods>? quantityPrices;
  List<InventoryGoods>? units;
  bool? hasAdditionalUnit;
  List<InventoryGoods>? values;
  List<InventoryGoods>? optionValues;
  List<InventoryGoods>? variants;
  List<InventoryGoods>? additionalUnits;
  List<InventoryGoods>? itemUnits;
  String? profileName;
  bool? isBase;
  double? availableQuantity;
  InventoryGoods? itemUnit;
  String? logo;
  String? padName;
  String? brandName;
  String? supplierName;
  String? manufacturerName;
  String? manufacturerCountryName;
  String? manufacturerCountryId;
  String? importerCountryName;
  String? distributorName;
  String? itemTypeName;
  String? classificationName;
  String? subClassificationName;
  String? categoryName;
  String? subCategoryName;
  String? tagName;
  String? regNumber;
  List<String>? urls;
  String? unitName;
  String? unitWeightLabel;
  String? unitWeightLabelId;
  String? unitSpaceLabel;
  String? unitSpaceLabelId;
  bool? isMain;
  String? option;
  String? optionId;
  InventoryGoods? partner;
  String? partnerName;
  String? businessName;
  double? customPrice;
  double? standardPrice;
  String? sectionName;
  bool? checked = false;
  int? number;
  String? fieldValueId;
  String? fieldValueName;
  String? sectionId;
  String? fieldId;
  String? fieldType;
  String? variantStatus;
  String? supplierTypeName;
  String? supplierTypeId;

  InventoryGoods({
    this.supplierTypeName,
    this.supplierTypeId,
    this.variantStatus,
    this.sectionId,
    this.fieldId,
    this.fieldType,
    this.fieldValueId,
    this.fieldValueName,
    this.number,
    this.checked,
    this.sectionName,
    this.customPrice,
    this.standardPrice,
    this.regNumber,
    this.partnerName,
    this.businessName,
    this.partner,
    this.isMain,
    this.option,
    this.optionId,
    this.returnTypeId,
    this.unitSpaceLabel,
    this.unitSpaceLabelId,
    this.unitWeightLabel,
    this.unitWeightLabelId,
    this.unitName,
    this.urls,
    this.padName,
    this.brandName,
    this.supplierName,
    this.manufacturerName,
    this.manufacturerCountryName,
    this.manufacturerCountryId,
    this.importerCountryName,
    this.distributorName,
    this.itemTypeName,
    this.classificationName,
    this.subClassificationName,
    this.categoryName,
    this.subCategoryName,
    this.tagName,
    this.logo,
    this.itemUnit,
    this.availableQuantity,
    this.profileName,
    this.isBase,
    this.optionValues,
    this.variants,
    this.additionalUnits,
    this.itemUnits,
    this.values,
    this.hasAdditionalUnit,
    this.reOrderMinNum,
    this.reOrder,
    this.minOrderNum,
    this.maxBalance,
    this.reOrderNum,
    this.minBalance,
    this.url,
    this.text,
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
    this.brand,
    this.supplier,
    this.manufacturer,
    this.originCountry,
    this.importerCountry,
    this.distributor,
    this.itemType,
    this.classification,
    this.subClassification,
    this.category,
    this.subCategory,
    this.tag,
    this.deliveryType,
    this.packageType,
    this.coverImages,
    this.detailImages,
    this.sections,
    this.sectionIds,
    this.fields,
    this.itemFieldValues,
    this.quantityPrices,
    this.units,
  });

  static $fromJson(Map<String, dynamic> json) => _$InventoryGoodsFromJson(json);

  factory InventoryGoods.fromJson(Map<String, dynamic> json) =>
      _$InventoryGoodsFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryGoodsToJson(this);
}

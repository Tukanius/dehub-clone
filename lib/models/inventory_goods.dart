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
  String? currency;
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
  bool? confirm;
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
  InventoryGoods? regUser;
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
  String? supplierType;
  String? baseUnitId;
  bool? isWarehouseSet;
  bool? isPriceSet;
  double? vatValue;
  String? vatType;
  bool? taxType;
  int? vatPercent;
  double? taxPercent;
  bool? hasTax;
  String? endDate; // Must be String
  String? startDate; // Must be String
  double? quantityPrice;
  int? minQuantity;
  bool? hasMaxLimit;
  int? maxQuantity;
  double? salesPrice;
  int? tierNo;
  bool? isSet;
  List<InventoryGoods>? tierPrices;
  double? price;
  String? variantId;
  InventoryGoods? variant;
  String? firstName;
  String? lastName;
  InventoryGoods? warehouseUser;
  InventoryGoods? warehouse;
  InventoryGoods? merchStaff;
  String? avatar;
  String? phone;
  String? email;
  String? warehouseId;
  String? quantityStartDate;
  double? warehouseQuantity;
  double? noticeMinQuantity;
  double? noticeMaxQuantity;
  double? deactivateMinQuantity;
  double? minOrderQuantity;
  double? reOrderQuantityLevel;
  double? reOrderQuantity;
  String? merchStaffId;
  List<InventoryGoods>? variantSuppliers;
  String? buyerBusinessId;
  String? supplierBusinessId;
  bool? isDefault;
  bool? isDropshipping;
  InventoryGoods? buyerBusiness;
  InventoryGoods? supplierBusiness;
  InventoryGoods? partnerBusiness;
  bool? backorderable;
  String? status;
  String? inactiveTypeId;
  String? goodsId;
  String? convertType;
  double? convertValue;
  double? floatValue;
  bool? isForLoad;
  List<String>? selections;
  List<InventoryGoods>? sectionFields;
  int? totalQuantity;
  int? reservedQuantity;
  int? loadingQuantity;
  int? onDeliveryQuantity;
  int? backorderQuantity;
  int? deliveredQuantity;
  String? movementType;
  String? adjustmentNoteId;
  String? reference;
  String? adjustmentStatus;
  Uri? excelUrl;
  String? priceStartDate;
  String? priceEndDate;
  InventoryGoods? coBusinessStaff;
  List<InventoryGoods>? coBusinessFinStaffs;
  String? priceGroupType;
  String? priceGroupStatus;
  String? priceGroupId;
  int? priceTierNo;
  List<String>? businessIds;
  double? tier0Price;
  double? tier1Price;
  double? tier2Price;
  double? tier3Price;
  double? tier4Price;
  double? tier5Price;
  double? tier6Price;
  double? tier7Price;
  double? tier8Price;
  double? tier9Price;
  double? tier10Price;
  int? variantCount;
  List<InventoryGoods>? tiers;
  String? perType;
  String? changeType;
  double? perValue;

  InventoryGoods({
    this.perValue,
    this.perType,
    this.changeType,
    this.tiers,
    this.variantCount,
    this.tier0Price,
    this.priceGroupStatus,
    this.tier1Price,
    this.tier2Price,
    this.tier3Price,
    this.tier4Price,
    this.tier5Price,
    this.tier6Price,
    this.tier7Price,
    this.tier8Price,
    this.tier9Price,
    this.tier10Price,
    this.priceGroupType,
    this.variant,
    this.priceGroupId,
    this.priceTierNo,
    this.businessIds,
    this.coBusinessFinStaffs,
    this.coBusinessStaff,
    this.priceStartDate,
    this.priceEndDate,
    this.excelUrl,
    this.adjustmentStatus,
    this.regUser,
    this.reference,
    this.movementType,
    this.adjustmentNoteId,
    this.totalQuantity,
    this.reservedQuantity,
    this.loadingQuantity,
    this.onDeliveryQuantity,
    this.backorderQuantity,
    this.deliveredQuantity,
    this.sectionFields,
    this.selections,
    this.goodsId,
    this.convertType,
    this.convertValue,
    this.floatValue,
    this.isForLoad,
    this.taxPercent,
    this.status,
    this.inactiveTypeId,
    this.backorderable,
    this.partnerBusiness,
    this.buyerBusiness,
    this.supplierBusiness,
    this.variantSuppliers,
    this.buyerBusinessId,
    this.supplierBusinessId,
    this.isDefault,
    this.isDropshipping,
    this.warehouseId,
    this.quantityStartDate,
    this.warehouseQuantity,
    this.noticeMinQuantity,
    this.noticeMaxQuantity,
    this.deactivateMinQuantity,
    this.minOrderQuantity,
    this.reOrderQuantityLevel,
    this.reOrderQuantity,
    this.merchStaffId,
    this.email,
    this.phone,
    this.avatar,
    this.lastName,
    this.merchStaff,
    this.firstName,
    this.warehouse,
    this.warehouseUser,
    this.confirm,
    this.variantId,
    this.price,
    this.tierPrices,
    this.isSet,
    this.tierNo,
    this.minQuantity,
    this.hasMaxLimit,
    this.maxQuantity,
    this.salesPrice,
    this.quantityPrice,
    this.endDate,
    this.startDate,
    this.hasTax,
    this.vatPercent,
    this.taxType,
    this.vatValue,
    this.vatType,
    this.isWarehouseSet,
    this.isPriceSet,
    this.baseUnitId,
    this.supplierTypeName,
    this.supplierType,
    this.variantStatus,
    this.sectionId,
    this.fieldId,
    this.fieldType,
    this.currency,
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

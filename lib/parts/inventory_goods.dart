part of '../models/inventory_goods.dart';

InventoryGoods _$InventoryGoodsFromJson(Map<String, dynamic> json) {
  return InventoryGoods(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => InventoryGoods.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    itemStatus:
        json['itemStatus'] != null ? json['itemStatus'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    skuCode: json['skuCode'] != null ? json['skuCode'] as String : null,
    barCode: json['barCode'] != null ? json['barCode'] as String : null,
    erpCode: json['erpCode'] != null ? json['erpCode'] as String : null,
    nameMon: json['nameMon'] != null ? json['nameMon'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    nameBill: json['nameBill'] != null ? json['nameBill'] as String : null,
    nameWeb: json['nameWeb'] != null ? json['nameWeb'] as String : null,
    nameApp: json['nameApp'] != null ? json['nameApp'] as String : null,
    deliveryTypeId: json['deliveryTypeId'] != null
        ? json['deliveryTypeId'] as String
        : null,
    supplierId:
        json['supplierId'] != null ? json['supplierId'] as String : null,
    brandId: json['brandId'] != null ? json['brandId'] as String : null,
    manufacturerId: json['manufacturerId'] != null
        ? json['manufacturerId'] as String
        : null,
    originCountryId: json['originCountryId'] != null
        ? json['originCountryId'] as String
        : null,
    importerCountryId: json['importerCountryId'] != null
        ? json['importerCountryId'] as String
        : null,
    distributorId:
        json['distributorId'] != null ? json['distributorId'] as String : null,
    itemTypeId:
        json['itemTypeId'] != null ? json['itemTypeId'] as String : null,
    classificationId: json['classificationId'] != null
        ? json['classificationId'] as String
        : null,
    subClassificationId: json['subClassificationId'] != null
        ? json['subClassificationId'] as String
        : null,
    categoryId:
        json['categoryId'] != null ? json['categoryId'] as String : null,
    subCategoryId:
        json['subCategoryId'] != null ? json['subCategoryId'] as String : null,
    tagId: json['tagId'] != null ? json['tagId'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    hasVariant: json['hasVariant'] != null ? json['hasVariant'] as bool : null,
    hasUnit: json['hasUnit'] != null ? json['hasUnit'] as bool : null,
    departmentUnitId: json['departmentUnitId'] != null
        ? json['departmentUnitId'] as String
        : null,
    departmentSubUnitId: json['departmentSubUnitId'] != null
        ? json['departmentSubUnitId'] as String
        : null,
    unitId: json['unitId'] != null ? json['unitId'] as String : null,
    height:
        json['height'] != null ? double.parse(json['height'].toString()) : null,
    width:
        json['width'] != null ? double.parse(json['width'].toString()) : null,
    length:
        json['length'] != null ? double.parse(json['length'].toString()) : null,
    weight:
        json['weight'] != null ? double.parse(json['weight'].toString()) : null,
    space:
        json['space'] != null ? double.parse(json['space'].toString()) : null,
    weightLabel:
        json['weightLabel'] != null ? json['weightLabel'] as String : null,
    spaceLabel:
        json['spaceLabel'] != null ? json['spaceLabel'] as String : null,
    returnAllow:
        json['returnAllow'] != null ? json['returnAllow'] as bool : null,
    returnType:
        json['returnType'] != null ? json['returnType'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    packageTypeId:
        json['packageTypeId'] != null ? json['packageTypeId'] as String : null,
    isCompleted:
        json['isCompleted'] != null ? json['isCompleted'] as bool : null,
    isFetch: json['isFetch'] != null ? json['isFetch'] as bool : null,
    catergory: json['catergory'] != null
        ? InventoryGoods.fromJson(json['catergory'] as Map<String, dynamic>)
        : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    fieldCount: json['fieldCount'] != null
        ? double.parse(json['fieldCount'].toString())
        : null,
    isPublic: json['isPublic'] != null ? json['isPublic'] as bool : null,
    isGoods: json['isGoods'] != null ? json['isGoods'] as bool : null,
    isService: json['isService'] != null ? json['isService'] as bool : null,
    isDehub: json['isDehub'] != null ? json['isDehub'] as bool : null,
    unit: json['unit'] != null
        ? InventoryGoods.fromJson(json['unit'] as Map<String, dynamic>)
        : null,
    quantity: json['quantity'] != null
        ? double.parse(json['quantity'].toString())
        : null,
  );
}

Map<String, dynamic> _$InventoryGoodsToJson(InventoryGoods instance) {
  Map<String, dynamic> json = {};
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.itemStatus != null) json['itemStatus'] = instance.itemStatus;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.skuCode != null) json['skuCode'] = instance.skuCode;
  if (instance.barCode != null) json['barCode'] = instance.barCode;
  if (instance.erpCode != null) json['erpCode'] = instance.erpCode;
  if (instance.nameMon != null) json['nameMon'] = instance.nameMon;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.nameBill != null) json['nameBill'] = instance.nameBill;
  if (instance.nameWeb != null) json['nameWeb'] = instance.nameWeb;
  if (instance.nameApp != null) json['nameApp'] = instance.nameApp;
  if (instance.deliveryTypeId != null)
    json['deliveryTypeId'] = instance.deliveryTypeId;
  if (instance.supplierId != null) json['supplierId'] = instance.supplierId;
  if (instance.brandId != null) json['brandId'] = instance.brandId;
  if (instance.manufacturerId != null)
    json['manufacturerId'] = instance.manufacturerId;
  if (instance.originCountryId != null)
    json['originCountryId'] = instance.originCountryId;
  if (instance.importerCountryId != null)
    json['importerCountryId'] = instance.importerCountryId;
  if (instance.distributorId != null)
    json['distributorId'] = instance.distributorId;
  if (instance.itemTypeId != null) json['itemTypeId'] = instance.itemTypeId;
  if (instance.classificationId != null)
    json['classificationId'] = instance.classificationId;
  if (instance.subClassificationId != null)
    json['subClassificationId'] = instance.subClassificationId;
  if (instance.categoryId != null) json['categoryId'] = instance.categoryId;
  if (instance.subCategoryId != null)
    json['subCategoryId'] = instance.subCategoryId;
  if (instance.tagId != null) json['tagId'] = instance.tagId;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.hasVariant != null) json['hasVariant'] = instance.hasVariant;
  if (instance.hasUnit != null) json['hasUnit'] = instance.hasUnit;
  if (instance.departmentUnitId != null)
    json['departmentUnitId'] = instance.departmentUnitId;
  if (instance.departmentSubUnitId != null)
    json['departmentSubUnitId'] = instance.departmentSubUnitId;
  if (instance.unitId != null) json['unitId'] = instance.unitId;
  if (instance.height != null) json['height'] = instance.height;
  if (instance.width != null) json['width'] = instance.width;
  if (instance.length != null) json['length'] = instance.length;
  if (instance.weight != null) json['weight'] = instance.weight;
  if (instance.space != null) json['space'] = instance.space;
  if (instance.weightLabel != null) json['weightLabel'] = instance.weightLabel;
  if (instance.spaceLabel != null) json['spaceLabel'] = instance.spaceLabel;
  if (instance.returnAllow != null) json['returnAllow'] = instance.returnAllow;
  if (instance.returnType != null) json['returnType'] = instance.returnType;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.packageTypeId != null)
    json['packageTypeId'] = instance.packageTypeId;
  if (instance.isCompleted != null) json['isCompleted'] = instance.isCompleted;
  if (instance.isFetch != null) json['isFetch'] = instance.isFetch;
  if (instance.catergory != null) json['catergory'] = instance.catergory;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.fieldCount != null) json['fieldCount'] = instance.fieldCount;
  if (instance.isPublic != null) json['isPublic'] = instance.isPublic;
  if (instance.isGoods != null) json['isGoods'] = instance.isGoods;
  if (instance.isService != null) json['isService'] = instance.isService;
  if (instance.isDehub != null) json['isDehub'] = instance.isDehub;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.quantity != null) json['quantity'] = instance.quantity;

  return json;
}

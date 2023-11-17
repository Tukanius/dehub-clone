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
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
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
    reOrder: json['reOrder'] != null ? json['reOrder'] as bool : null,
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
    brand: json['brand'] != null
        ? InventoryGoods.fromJson(json['brand'] as Map<String, dynamic>)
        : null,
    supplier: json['supplier'] != null
        ? InventoryGoods.fromJson(json['supplier'] as Map<String, dynamic>)
        : null,
    manufacturer: json['manufacturer'] != null
        ? InventoryGoods.fromJson(json['manufacturer'] as Map<String, dynamic>)
        : null,
    originCountry:
        json['originCountry'] != null ? json['originCountry'] as String : null,
    importerCountry: json['importerCountry'] != null
        ? json['importerCountry'] as String
        : null,

    distributor: json['distributor'] != null
        ? InventoryGoods.fromJson(json['distributor'] as Map<String, dynamic>)
        : null,
    itemType: json['itemType'] != null
        ? InventoryGoods.fromJson(json['itemType'] as Map<String, dynamic>)
        : null,
    classification: json['classification'] != null
        ? InventoryGoods.fromJson(
            json['classification'] as Map<String, dynamic>)
        : null,
    subClassification: json['subClassification'] != null
        ? InventoryGoods.fromJson(
            json['subClassification'] as Map<String, dynamic>)
        : null,
    category: json['category'] != null
        ? InventoryGoods.fromJson(json['category'] as Map<String, dynamic>)
        : null,
    subCategory: json['subCategory'] != null
        ? InventoryGoods.fromJson(json['subCategory'] as Map<String, dynamic>)
        : null,
    tag: json['tag'] != null
        ? InventoryGoods.fromJson(json['tag'] as Map<String, dynamic>)
        : null,
    deliveryType: json['deliveryType'] != null
        ? InventoryGoods.fromJson(json['deliveryType'] as Map<String, dynamic>)
        : null,
    packageType: json['packageType'] != null
        ? InventoryGoods.fromJson(json['packageType'] as Map<String, dynamic>)
        : null,
    coverImages: json['coverImages'] != null
        ? (json['coverImages'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    detailImages: (json['detailImages'] != null)
        ? (json['detailImages'] as List).map((e) => e as String).toList()
        : null,
    // detailImages: json['detailImages'] != null
    //     ? (json['detailImages'] as List)
    //         .map((e) => InventoryGoods.fromJson(e))
    //         .toList()
    //     : null,
    sections: json['sections'] != null
        ? (json['sections'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    sectionIds: json['sectionIds'] != null
        ? (json['sectionIds'] as List).map((e) => e as String).toList()
        : null,
    fields: json['fields'] != null
        ? (json['fields'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    itemFieldValues: json['itemFieldValues'] != null
        ? (json['itemFieldValues'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    quantityPrices: json['quantityPrices'] != null
        ? (json['quantityPrices'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    units: json['units'] != null
        ? (json['units'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    text: json['text'] != null ? json['text'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    minBalance: json['minBalance'] != null
        ? double.parse(json['minBalance'].toString())
        : null,
    maxBalance: json['maxBalance'] != null
        ? double.parse(json['maxBalance'].toString())
        : null,
    minOrderNum: json['minOrderNum'] != null
        ? double.parse(json['minOrderNum'].toString())
        : null,
    reOrderNum: json['reOrderNum'] != null
        ? double.parse(json['reOrderNum'].toString())
        : null,
    reOrderMinNum: json['reOrderMinNum'] != null
        ? double.parse(json['reOrderMinNum'].toString())
        : null,
    optionValues: json['optionValues'] != null
        ? (json['optionValues'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    variants: json['variants'] != null
        ? (json['variants'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    additionalUnits: json['additionalUnits'] != null
        ? (json['additionalUnits'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    itemUnits: json['itemUnits'] != null
        ? (json['itemUnits'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    // values: json['values'] != null
    //     ? InventoryGoods.fromJson(json['values'] as Map<String, dynamic>)
    //     : null,
    hasAdditionalUnit: json['hasAdditionalUnit'] != null
        ? json['hasAdditionalUnit'] as bool
        : null,
    isBase: json['isBase'] != null ? json['isBase'] as bool : null,
  );
}

Map<String, dynamic> _$InventoryGoodsToJson(InventoryGoods instance) {
  Map<String, dynamic> json = {};

  if (instance.optionValues != null)
    json['optionValues'] = instance.optionValues;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.isBase != null) json['isBase'] = instance.isBase;
  if (instance.variants != null) json['variants'] = instance.variants;
  if (instance.additionalUnits != null)
    json['additionalUnits'] = instance.additionalUnits;
  if (instance.itemUnits != null) json['itemUnits'] = instance.itemUnits;
  // if (instance.values != null) json['values'] = instance.values;
  if (instance.hasAdditionalUnit != null)
    json['hasAdditionalUnit'] = instance.hasAdditionalUnit;
  if (instance.reOrderMinNum != null)
    json['reOrderMinNum'] = instance.reOrderMinNum;
  if (instance.reOrderNum != null) json['reOrderNum'] = instance.reOrderNum;
  if (instance.reOrder != null) json['reOrder'] = instance.reOrder;
  if (instance.minOrderNum != null) json['minOrderNum'] = instance.minOrderNum;
  if (instance.maxBalance != null) json['maxBalance'] = instance.maxBalance;
  if (instance.minBalance != null) json['minBalance'] = instance.minBalance;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.text != null) json['text'] = instance.text;
  if (instance.brand != null) json['brand'] = instance.brand;
  if (instance.supplier != null) json['supplier'] = instance.supplier;
  if (instance.manufacturer != null)
    json['manufacturer'] = instance.manufacturer;
  if (instance.originCountry != null)
    json['originCountry'] = instance.originCountry;
  if (instance.importerCountry != null)
    json['importerCountry'] = instance.importerCountry;
  if (instance.distributor != null) json['distributor'] = instance.distributor;
  if (instance.itemType != null) json['itemType'] = instance.itemType;
  if (instance.classification != null)
    json['classification'] = instance.classification;
  if (instance.subClassification != null)
    json['subClassification'] = instance.subClassification;
  if (instance.category != null) json['category'] = instance.category;
  if (instance.subCategory != null) json['subCategory'] = instance.subCategory;
  if (instance.tag != null) json['tag'] = instance.tag;
  if (instance.deliveryType != null)
    json['deliveryType'] = instance.deliveryType;
  if (instance.packageType != null) json['packageType'] = instance.packageType;
  if (instance.coverImages != null) json['coverImages'] = instance.coverImages;
  if (instance.detailImages != null)
    json['detailImages'] = instance.detailImages;
  if (instance.sections != null) json['sections'] = instance.sections;
  if (instance.sectionIds != null) json['sectionIds'] = instance.sectionIds;
  if (instance.fields != null) json['fields'] = instance.fields;
  if (instance.itemFieldValues != null)
    json['itemFieldValues'] = instance.itemFieldValues;
  if (instance.quantityPrices != null)
    json['quantityPrices'] = instance.quantityPrices;
  if (instance.units != null) json['units'] = instance.units;

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

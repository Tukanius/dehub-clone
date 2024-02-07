part of '../models/inventory_goods.dart';

InventoryGoods _$InventoryGoodsFromJson(Map<String, dynamic> json) {
  return InventoryGoods(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    vatValue: json['vatValue'] != null
        ? double.parse(json['vatValue'].toString())
        : null,
    convertType:
        json['convertType'] != null ? json['convertType'] as String : null,
    convertValue: json['convertValue'] != null
        ? double.parse(json['convertValue'].toString())
        : null,
    floatValue: json['floatValue'] != null
        ? double.parse(json['floatValue'].toString())
        : null,
    isForLoad: json['isForLoad'] != null ? json['isForLoad'] as bool : null,
    taxPercent: json['taxPercent'] != null
        ? double.parse(json['taxPercent'].toString())
        : null,
    number:
        json['number'] != null ? int.parse(json['number'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => InventoryGoods.fromJson(e)).toList()
        : null,
    tiers: json['tiers'] != null
        ? (json['tiers'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    sectionFields: json['sectionFields'] != null
        ? (json['sectionFields'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    tierPrices: json['tierPrices'] != null
        ? (json['tierPrices'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    selections: json['selections'] != null
        ? (json['selections'] as List).map((e) => e as String).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    adjustmentNoteId: json['adjustmentNoteId'] != null
        ? json['adjustmentNoteId'] as String
        : null,
    movementType:
        json['movementType'] != null ? json['movementType'] as String : null,
    adjustmentStatus: json['adjustmentStatus'] != null
        ? json['adjustmentStatus'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    priceGroupStatus: json['priceGroupStatus'] != null
        ? json['priceGroupStatus'] as String
        : null,
    inactiveTypeId: json['inactiveTypeId'] != null
        ? json['inactiveTypeId'] as String
        : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    reference: json['reference'] != null ? json['reference'] as String : null,
    goodsId: json['goodsId'] != null ? json['goodsId'] as String : null,
    status: json['status'] != null ? json['status'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    priceEndDate:
        json['priceEndDate'] != null ? json['priceEndDate'] as String : null,
    priceStartDate: json['priceStartDate'] != null
        ? json['priceStartDate'] as String
        : null,
    excelUrl: json['excelUrl'] != null
        ? Uri.parse(json['excelUrl'].toString())
        : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    unitName: json['unitName'] != null ? json['unitName'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    variantId: json['variantId'] != null ? json['variantId'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    confirm: json['confirm'] != null ? json['confirm'] as bool : null,
    backorderable:
        json['backorderable'] != null ? json['backorderable'] as bool : null,
    fieldValueName: json['fieldValueName'] != null
        ? json['fieldValueName'] as String
        : null,
    fieldValueId:
        json['fieldValueId'] != null ? json['fieldValueId'] as String : null,
    baseUnitId:
        json['baseUnitId'] != null ? json['baseUnitId'] as String : null,
    supplierType:
        json['supplierType'] != null ? json['supplierType'] as String : null,
    supplierTypeName: json['supplierTypeName'] != null
        ? json['supplierTypeName'] as String
        : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    variantStatus:
        json['variantStatus'] != null ? json['variantStatus'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    itemStatus:
        json['itemStatus'] != null ? json['itemStatus'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    skuCode: json['skuCode'] != null ? json['skuCode'] as String : null,
    hasTax: json['hasTax'] != null ? json['hasTax'] as bool : null,
    checked: json['checked'] != null ? json['checked'] as bool : null,
    taxType: json['taxType'] != null ? json['taxType'] as bool : null,
    isPriceSet: json['isPriceSet'] != null ? json['isPriceSet'] as bool : null,
    barCode: json['barCode'] != null ? json['barCode'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    option: json['option'] != null ? json['option'] as String : null,
    optionId: json['optionId'] != null ? json['optionId'] as String : null,
    startDate: json['startDate'] != null ? json['startDate'] as String : null,
    endDate: json['endDate'] != null ? json['endDate'] as String : null,
    sectionName:
        json['sectionName'] != null ? json['sectionName'] as String : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => e as String).toList()
        : null,
    erpCode: json['erpCode'] != null ? json['erpCode'] as String : null,
    nameMon: json['nameMon'] != null ? json['nameMon'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    nameBill: json['nameBill'] != null ? json['nameBill'] as String : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
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
    perType: json['perType'] != null ? json['perType'] as String : null,
    changeType:
        json['changeType'] != null ? json['changeType'] as String : null,
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
    isWarehouseSet:
        json['isWarehouseSet'] != null ? json['isWarehouseSet'] as bool : null,
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
    perValue: json['perValue'] != null
        ? double.parse(json['perValue'].toString())
        : null,
    price:
        json['price'] != null ? double.parse(json['price'].toString()) : null,
    quantityPrice: json['quantityPrice'] != null
        ? double.parse(json['quantityPrice'].toString())
        : null,
    vatPercent: json['vatPercent'] != null
        ? int.parse(json['vatPercent'].toString())
        : null,
    variantCount: json['variantCount'] != null
        ? int.parse(json['variantCount'].toString())
        : null,
    totalQuantity: json['totalQuantity'] != null
        ? int.parse(json['totalQuantity'].toString())
        : null,
    reservedQuantity: json['reservedQuantity'] != null
        ? int.parse(json['reservedQuantity'].toString())
        : null,
    loadingQuantity: json['loadingQuantity'] != null
        ? int.parse(json['loadingQuantity'].toString())
        : null,
    onDeliveryQuantity: json['onDeliveryQuantity'] != null
        ? int.parse(json['onDeliveryQuantity'].toString())
        : null,
    backorderQuantity: json['backorderQuantity'] != null
        ? int.parse(json['backorderQuantity'].toString())
        : null,
    deliveredQuantity: json['deliveredQuantity'] != null
        ? int.parse(json['deliveredQuantity'].toString())
        : null,
    tierNo:
        json['tierNo'] != null ? int.parse(json['tierNo'].toString()) : null,
    availableQuantity: json['availableQuantity'] != null
        ? double.parse(json['availableQuantity'].toString())
        : null,
    standardPrice: json['standardPrice'] != null
        ? double.parse(json['standardPrice'].toString())
        : null,
    customPrice: json['customPrice'] != null
        ? double.parse(json['customPrice'].toString())
        : null,
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
    isSet: json['isSet'] != null ? json['isSet'] as bool : null,
    returnType:
        json['returnType'] != null ? json['returnType'] as String : null,
    returnTypeId:
        json['returnTypeId'] != null ? json['returnTypeId'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    packageTypeId:
        json['packageTypeId'] != null ? json['packageTypeId'] as String : null,
    isCompleted:
        json['isCompleted'] != null ? json['isCompleted'] as bool : null,
    isFetch: json['isFetch'] != null ? json['isFetch'] as bool : null,
    catergory: json['catergory'] != null
        ? InventoryGoods.fromJson(json['catergory'] as Map<String, dynamic>)
        : null,
    variant: json['variant'] != null
        ? InventoryGoods.fromJson(json['variant'] as Map<String, dynamic>)
        : null,
    coBusinessStaff: json['coBusinessStaff'] != null
        ? InventoryGoods.fromJson(
            json['coBusinessStaff'] as Map<String, dynamic>)
        : null,
    coBusinessFinStaffs: json['coBusinessFinStaffs'] != null
        ? (json['coBusinessFinStaffs'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    regUser: json['regUser'] != null
        ? InventoryGoods.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    merchStaff: json['merchStaff'] != null
        ? InventoryGoods.fromJson(json['merchStaff'] as Map<String, dynamic>)
        : null,
    buyerBusiness: json['buyerBusiness'] != null
        ? InventoryGoods.fromJson(json['buyerBusiness'] as Map<String, dynamic>)
        : null,
    supplierBusiness: json['supplierBusiness'] != null
        ? InventoryGoods.fromJson(
            json['supplierBusiness'] as Map<String, dynamic>)
        : null,
    warehouseUser: json['warehouseUser'] != null
        ? InventoryGoods.fromJson(json['warehouseUser'] as Map<String, dynamic>)
        : null,
    warehouse: json['warehouse'] != null
        ? InventoryGoods.fromJson(json['warehouse'] as Map<String, dynamic>)
        : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
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
    partner: json['partner'] != null
        ? InventoryGoods.fromJson(json['partner'] as Map<String, dynamic>)
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
    itemUnit: json['itemUnit'] != null
        ? InventoryGoods.fromJson(json['itemUnit'] as Map<String, dynamic>)
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
    partnerBusiness: json['partnerBusiness'] != null
        ? InventoryGoods.fromJson(
            json['partnerBusiness'] as Map<String, dynamic>)
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
    values: json['values'] != null
        ? (json['values'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    hasAdditionalUnit: json['hasAdditionalUnit'] != null
        ? json['hasAdditionalUnit'] as bool
        : null,
    isBase: json['isBase'] != null ? json['isBase'] as bool : null,
    brandName: json['brandName'] != null ? json['brandName'] as String : null,
    supplierName:
        json['supplierName'] != null ? json['supplierName'] as String : null,
    manufacturerName: json['manufacturerName'] != null
        ? json['manufacturerName'] as String
        : null,
    manufacturerCountryName: json['manufacturerCountryName'] != null
        ? json['manufacturerCountryName'] as String
        : null,
    manufacturerCountryId: json['manufacturerCountryId'] != null
        ? json['manufacturerCountryId'] as String
        : null,
    vatType: json['vatType'] != null ? json['vatType'] as String : null,
    importerCountryName: json['importerCountryName'] != null
        ? json['importerCountryName'] as String
        : null,
    distributorName: json['distributorName'] != null
        ? json['distributorName'] as String
        : null,
    itemTypeName:
        json['itemTypeName'] != null ? json['itemTypeName'] as String : null,
    classificationName: json['classificationName'] != null
        ? json['classificationName'] as String
        : null,
    subClassificationName: json['subClassificationName'] != null
        ? json['subClassificationName'] as String
        : null,
    categoryName:
        json['categoryName'] != null ? json['categoryName'] as String : null,
    subCategoryName: json['subCategoryName'] != null
        ? json['subCategoryName'] as String
        : null,
    tagName: json['tagName'] != null ? json['tagName'] as String : null,
    unitWeightLabel: json['unitWeightLabel'] != null
        ? json['unitWeightLabel'] as String
        : null,
    unitWeightLabelId: json['unitWeightLabelId'] != null
        ? json['unitWeightLabelId'] as String
        : null,
    unitSpaceLabel: json['unitSpaceLabel'] != null
        ? json['unitSpaceLabel'] as String
        : null,
    unitSpaceLabelId: json['unitSpaceLabelId'] != null
        ? json['unitSpaceLabelId'] as String
        : null,
    sectionId: json['sectionId'] != null ? json['sectionId'] as String : null,
    fieldId: json['fieldId'] != null ? json['fieldId'] as String : null,
    fieldType: json['fieldType'] != null ? json['fieldType'] as String : null,
    minQuantity: json['minQuantity'] != null
        ? int.parse(json['minQuantity'].toString())
        : null,
    hasMaxLimit:
        json['hasMaxLimit'] != null ? json['hasMaxLimit'] as bool : null,
    maxQuantity: json['maxQuantity'] != null
        ? int.parse(json['maxQuantity'].toString())
        : null,
    salesPrice: json['salesPrice'] != null
        ? double.parse(json['salesPrice'].toString())
        : null,
    warehouseId:
        json['warehouseId'] != null ? json['warehouseId'] as String : null,
    quantityStartDate: json['quantityStartDate'] != null
        ? json['quantityStartDate'] as String
        : null,
    warehouseQuantity: json['warehouseQuantity'] != null
        ? double.parse(json['warehouseQuantity'].toString())
        : null,
    noticeMinQuantity: json['noticeMinQuantity'] != null
        ? double.parse(json['noticeMinQuantity'].toString())
        : null,
    noticeMaxQuantity: json['noticeMaxQuantity'] != null
        ? double.parse(json['noticeMaxQuantity'].toString())
        : null,
    deactivateMinQuantity: json['deactivateMinQuantity'] != null
        ? double.parse(json['deactivateMinQuantity'].toString())
        : null,
    minOrderQuantity: json['minOrderQuantity'] != null
        ? double.parse(json['minOrderQuantity'].toString())
        : null,
    reOrderQuantityLevel: json['reOrderQuantityLevel'] != null
        ? double.parse(json['reOrderQuantityLevel'].toString())
        : null,
    reOrderQuantity: json['reOrderQuantity'] != null
        ? double.parse(json['reOrderQuantity'].toString())
        : null,
    merchStaffId:
        json['merchStaffId'] != null ? json['merchStaffId'] as String : null,
    variantSuppliers: json['variantSuppliers'] != null
        ? (json['variantSuppliers'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    buyerBusinessId: json['buyerBusinessId'] != null
        ? json['buyerBusinessId'] as String
        : null,
    supplierBusinessId: json['supplierBusinessId'] != null
        ? json['supplierBusinessId'] as String
        : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    isDropshipping:
        json['isDropshipping'] != null ? json['isDropshipping'] as bool : null,
    priceGroupType: json['priceGroupType'] != null
        ? json['priceGroupType'] as String
        : null,
    priceGroupId:
        json['priceGroupId'] != null ? json['priceGroupId'] as String : null,
    priceTierNo: json['priceTierNo'] != null
        ? int.parse(json['priceTierNo'].toString())
        : null,
    businessIds: json['businessIds'] != null
        ? (json['businessIds'] as List).map((e) => e as String).toList()
        : null,
    tier0Price: json['tier0Price'] != null
        ? double.parse(json['tier0Price'].toString())
        : null,
    tier1Price: json['tier1Price'] != null
        ? double.parse(json['tier1Price'].toString())
        : null,
    tier2Price: json['tier2Price'] != null
        ? double.parse(json['tier2Price'].toString())
        : null,
    tier3Price: json['tier3Price'] != null
        ? double.parse(json['tier3Price'].toString())
        : null,
    tier4Price: json['tier4Price'] != null
        ? double.parse(json['tier4Price'].toString())
        : null,
    tier5Price: json['tier5Price'] != null
        ? double.parse(json['tier5Price'].toString())
        : null,
    tier6Price: json['tier6Price'] != null
        ? double.parse(json['tier6Price'].toString())
        : null,
    tier7Price: json['tier7Price'] != null
        ? double.parse(json['tier7Price'].toString())
        : null,
    tier8Price: json['tier8Price'] != null
        ? double.parse(json['tier8Price'].toString())
        : null,
    tier9Price: json['tier9Price'] != null
        ? double.parse(json['tier9Price'].toString())
        : null,
    tier10Price: json['tier10Price'] != null
        ? double.parse(json['tier10Price'].toString())
        : null,
  );
}

Map<String, dynamic> _$InventoryGoodsToJson(InventoryGoods instance) {
  Map<String, dynamic> json = {};
  if (instance.tier0Price != null) json['tier0Price'] = instance.tier0Price;
  if (instance.tier1Price != null) json['tier1Price'] = instance.tier1Price;
  if (instance.tier2Price != null) json['tier2Price'] = instance.tier2Price;
  if (instance.tier3Price != null) json['tier3Price'] = instance.tier3Price;
  if (instance.tier4Price != null) json['tier4Price'] = instance.tier4Price;
  if (instance.tier5Price != null) json['tier5Price'] = instance.tier5Price;
  if (instance.tier6Price != null) json['tier6Price'] = instance.tier6Price;
  if (instance.tier7Price != null) json['tier7Price'] = instance.tier7Price;
  if (instance.tier8Price != null) json['tier8Price'] = instance.tier8Price;
  if (instance.tier9Price != null) json['tier9Price'] = instance.tier9Price;
  if (instance.tier10Price != null) json['tier10Price'] = instance.tier10Price;
  if (instance.perType != null) json['perType'] = instance.perType;
  if (instance.changeType != null) json['changeType'] = instance.changeType;
  if (instance.perValue != null) json['perValue'] = instance.perValue;
  if (instance.tiers != null) json['tiers'] = instance.tiers;
  if (instance.variantCount != null) {
    json['variantCount'] = instance.variantCount;
  }
  if (instance.priceGroupType != null) {
    json['priceGroupType'] = instance.priceGroupType;
  }
  if (instance.priceGroupStatus != null) {
    json['priceGroupStatus'] = instance.priceGroupStatus;
  }
  if (instance.priceGroupId != null) {
    json['priceGroupId'] = instance.priceGroupId;
  }
  if (instance.priceTierNo != null) json['priceTierNo'] = instance.priceTierNo;
  if (instance.businessIds != null) json['businessIds'] = instance.businessIds;
  if (instance.totalQuantity != null) {
    json['totalQuantity'] = instance.totalQuantity;
  }
  if (instance.excelUrl != null) {
    json['excelUrl'] = instance.excelUrl;
  }
  if (instance.reference != null) json['reference'] = instance.reference;
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.reservedQuantity != null) {
    json['reservedQuantity'] = instance.reservedQuantity;
  }
  if (instance.variant != null) json['variant'] = instance.variant;

  if (instance.priceEndDate != null) {
    json['priceEndDate'] = instance.priceEndDate;
  }
  if (instance.priceStartDate != null) {
    json['priceStartDate'] = instance.priceStartDate;
  }
  if (instance.loadingQuantity != null) {
    json['loadingQuantity'] = instance.loadingQuantity;
  }
  if (instance.adjustmentStatus != null) {
    json['adjustmentStatus'] = instance.adjustmentStatus;
  }
  if (instance.onDeliveryQuantity != null) {
    json['onDeliveryQuantity'] = instance.onDeliveryQuantity;
  }
  if (instance.backorderQuantity != null) {
    json['backorderQuantity'] = instance.backorderQuantity;
  }
  if (instance.deliveredQuantity != null) {
    json['deliveredQuantity'] = instance.deliveredQuantity;
  }
  if (instance.sectionFields != null) {
    json['sectionFields'] = instance.sectionFields;
  }
  if (instance.selections != null) json['selections'] = instance.selections;
  if (instance.convertType != null) json['convertType'] = instance.convertType;
  if (instance.goodsId != null) json['goodsId'] = instance.goodsId;
  if (instance.convertValue != null) {
    json['convertValue'] = instance.convertValue;
  }
  if (instance.floatValue != null) json['floatValue'] = instance.floatValue;
  if (instance.isForLoad != null) json['isForLoad'] = instance.isForLoad;
  if (instance.variantSuppliers != null) {
    json['variantSuppliers'] = instance.variantSuppliers;
  }
  if (instance.taxPercent != null) json['taxPercent'] = instance.taxPercent;
  if (instance.partnerBusiness != null) {
    json['partnerBusiness'] = instance.partnerBusiness;
  }
  if (instance.buyerBusinessId != null) {
    json['buyerBusinessId'] = instance.buyerBusinessId;
  }
  if (instance.supplierBusinessId != null) {
    json['supplierBusinessId'] = instance.supplierBusinessId;
  }
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isDropshipping != null) {
    json['isDropshipping'] = instance.isDropshipping;
  }
  if (instance.warehouseId != null) json['warehouseId'] = instance.warehouseId;
  if (instance.quantityStartDate != null) {
    json['quantityStartDate'] = instance.quantityStartDate;
  }
  if (instance.warehouseQuantity != null) {
    json['warehouseQuantity'] = instance.warehouseQuantity;
  }
  if (instance.noticeMinQuantity != null) {
    json['noticeMinQuantity'] = instance.noticeMinQuantity;
  }
  if (instance.noticeMaxQuantity != null) {
    json['noticeMaxQuantity'] = instance.noticeMaxQuantity;
  }
  if (instance.deactivateMinQuantity != null) {
    json['deactivateMinQuantity'] = instance.deactivateMinQuantity;
  }
  if (instance.minOrderQuantity != null) {
    json['minOrderQuantity'] = instance.minOrderQuantity;
  }
  if (instance.reOrderQuantityLevel != null) {
    json['reOrderQuantityLevel'] = instance.reOrderQuantityLevel;
  }
  if (instance.reOrderQuantity != null) {
    json['reOrderQuantity'] = instance.reOrderQuantity;
  }
  if (instance.merchStaffId != null) {
    json['merchStaffId'] = instance.merchStaffId;
  }
  if (instance.variantStatus != null) {
    json['variantStatus'] = instance.variantStatus;
  }
  if (instance.warehouseUser != null) {
    json['warehouseUser'] = instance.warehouseUser;
  }
  if (instance.supplierBusiness != null) {
    json['supplierBusiness'] = instance.supplierBusiness;
  }
  if (instance.coBusinessFinStaffs != null) {
    json['coBusinessFinStaffs'] = instance.coBusinessFinStaffs;
  }
  if (instance.coBusinessStaff != null) {
    json['coBusinessStaff'] = instance.coBusinessStaff;
  }
  if (instance.buyerBusiness != null) {
    json['buyerBusiness'] = instance.buyerBusiness;
  }
  if (instance.inactiveTypeId != null) {
    json['inactiveTypeId'] = instance.inactiveTypeId;
  }
  if (instance.status != null) json['status'] = instance.status;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.warehouse != null) json['warehouse'] = instance.warehouse;
  if (instance.tierNo != null) json['tierNo'] = instance.tierNo;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.confirm != null) json['confirm'] = instance.confirm;
  if (instance.minQuantity != null) json['minQuantity'] = instance.minQuantity;
  if (instance.merchStaff != null) json['merchStaff'] = instance.merchStaff;
  if (instance.hasMaxLimit != null) json['hasMaxLimit'] = instance.hasMaxLimit;
  if (instance.maxQuantity != null) json['maxQuantity'] = instance.maxQuantity;
  if (instance.salesPrice != null) json['salesPrice'] = instance.salesPrice;
  if (instance.hasTax != null) json['hasTax'] = instance.hasTax;
  if (instance.vatPercent != null) json['vatPercent'] = instance.vatPercent;
  if (instance.taxType != null) json['taxType'] = instance.taxType;
  if (instance.baseUnitId != null) json['baseUnitId'] = instance.baseUnitId;
  if (instance.sectionId != null) json['sectionId'] = instance.sectionId;
  if (instance.fieldId != null) json['fieldId'] = instance.fieldId;
  if (instance.fieldType != null) json['fieldType'] = instance.fieldType;
  if (instance.isPriceSet != null) json['isPriceSet'] = instance.isPriceSet;
  if (instance.backorderable != null) {
    json['backorderable'] = instance.backorderable;
  }
  if (instance.adjustmentNoteId != null) {
    json['adjustmentNoteId'] = instance.adjustmentNoteId;
  }
  if (instance.movementType != null) {
    json['movementType'] = instance.movementType;
  }
  if (instance.tierPrices != null) json['tierPrices'] = instance.tierPrices;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.endDate != null) json['endDate'] = instance.endDate;
  if (instance.fieldValueName != null) {
    json['fieldValueName'] = instance.fieldValueName;
  }
  if (instance.fieldValueId != null) {
    json['fieldValueId'] = instance.fieldValueId;
  }
  if (instance.supplierType != null) {
    json['supplierType'] = instance.supplierType;
  }
  if (instance.supplierTypeName != null) {
    json['supplierTypeName'] = instance.supplierTypeName;
  }
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.checked != null) json['checked'] = instance.checked;
  if (instance.businessName != null) {
    json['businessName'] = instance.businessName;
  }
  if (instance.standardPrice != null) {
    json['standardPrice'] = instance.standardPrice;
  }
  if (instance.customPrice != null) json['customPrice'] = instance.customPrice;
  if (instance.variantId != null) json['variantId'] = instance.variantId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.unitSpaceLabel != null) {
    json['unitSpaceLabel'] = instance.unitSpaceLabel;
  }
  if (instance.price != null) json['price'] = instance.price;
  if (instance.vatValue != null) json['vatValue'] = instance.vatValue;
  if (instance.unitSpaceLabelId != null) {
    json['unitSpaceLabelId'] = instance.unitSpaceLabelId;
  }
  if (instance.unitWeightLabel != null) {
    json['unitWeightLabel'] = instance.unitWeightLabel;
  }
  if (instance.unitWeightLabelId != null) {
    json['unitWeightLabelId'] = instance.unitWeightLabelId;
  }
  if (instance.quantityPrice != null) {
    json['quantityPrice'] = instance.quantityPrice;
  }
  if (instance.sectionName != null) json['sectionName'] = instance.sectionName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.option != null) json['option'] = instance.option;
  if (instance.optionId != null) json['optionId'] = instance.optionId;
  if (instance.urls != null) json['urls'] = instance.urls;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.unitName != null) json['unitName'] = instance.unitName;
  if (instance.brandName != null) json['brandName'] = instance.brandName;
  if (instance.supplierName != null) {
    json['supplierName'] = instance.supplierName;
  }
  if (instance.manufacturerName != null) {
    json['manufacturerName'] = instance.manufacturerName;
  }
  if (instance.manufacturerCountryName != null) {
    json['manufacturerCountryName'] = instance.manufacturerCountryName;
  }
  if (instance.manufacturerCountryId != null) {
    json['manufacturerCountryId'] = instance.manufacturerCountryId;
  }
  if (instance.isWarehouseSet != null) {
    json['isWarehouseSet'] = instance.isWarehouseSet;
  }
  if (instance.importerCountryName != null) {
    json['importerCountryName'] = instance.importerCountryName;
  }
  if (instance.distributorName != null) {
    json['distributorName'] = instance.distributorName;
  }
  if (instance.itemTypeName != null) {
    json['itemTypeName'] = instance.itemTypeName;
  }
  if (instance.classificationName != null) {
    json['classificationName'] = instance.classificationName;
  }
  if (instance.subClassificationName != null) {
    json['subClassificationName'] = instance.subClassificationName;
  }
  if (instance.categoryName != null) {
    json['categoryName'] = instance.categoryName;
  }
  if (instance.subCategoryName != null) {
    json['subCategoryName'] = instance.subCategoryName;
  }
  if (instance.tagName != null) json['tagName'] = instance.tagName;
  if (instance.optionValues != null) {
    json['optionValues'] = instance.optionValues;
  }
  if (instance.vatType != null) json['vatType'] = instance.vatType;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.isBase != null) json['isBase'] = instance.isBase;
  if (instance.variants != null) json['variants'] = instance.variants;
  if (instance.additionalUnits != null) {
    json['additionalUnits'] = instance.additionalUnits;
  }
  if (instance.itemUnits != null) json['itemUnits'] = instance.itemUnits;
  if (instance.values != null) json['values'] = instance.values;
  if (instance.hasAdditionalUnit != null) {
    json['hasAdditionalUnit'] = instance.hasAdditionalUnit;
  }
  if (instance.reOrderMinNum != null) {
    json['reOrderMinNum'] = instance.reOrderMinNum;
  }
  if (instance.reOrderNum != null) json['reOrderNum'] = instance.reOrderNum;
  if (instance.reOrder != null) json['reOrder'] = instance.reOrder;
  if (instance.minOrderNum != null) json['minOrderNum'] = instance.minOrderNum;
  if (instance.maxBalance != null) json['maxBalance'] = instance.maxBalance;
  if (instance.minBalance != null) json['minBalance'] = instance.minBalance;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.text != null) json['text'] = instance.text;
  if (instance.brand != null) json['brand'] = instance.brand;
  if (instance.supplier != null) json['supplier'] = instance.supplier;
  if (instance.manufacturer != null) {
    json['manufacturer'] = instance.manufacturer;
  }
  if (instance.originCountry != null) {
    json['originCountry'] = instance.originCountry;
  }
  if (instance.importerCountry != null) {
    json['importerCountry'] = instance.importerCountry;
  }
  if (instance.distributor != null) json['distributor'] = instance.distributor;
  if (instance.itemType != null) json['itemType'] = instance.itemType;
  if (instance.classification != null) {
    json['classification'] = instance.classification;
  }
  if (instance.subClassification != null) {
    json['subClassification'] = instance.subClassification;
  }
  if (instance.category != null) json['category'] = instance.category;
  if (instance.subCategory != null) json['subCategory'] = instance.subCategory;
  if (instance.tag != null) json['tag'] = instance.tag;
  if (instance.deliveryType != null) {
    json['deliveryType'] = instance.deliveryType;
  }
  if (instance.packageType != null) json['packageType'] = instance.packageType;
  if (instance.coverImages != null) json['coverImages'] = instance.coverImages;
  if (instance.detailImages != null) {
    json['detailImages'] = instance.detailImages;
  }
  if (instance.sections != null) json['sections'] = instance.sections;
  if (instance.sectionIds != null) json['sectionIds'] = instance.sectionIds;
  if (instance.fields != null) json['fields'] = instance.fields;
  if (instance.itemUnit != null) json['itemUnit'] = instance.itemUnit;
  if (instance.itemFieldValues != null) {
    json['itemFieldValues'] = instance.itemFieldValues;
  }
  if (instance.quantityPrices != null) {
    json['quantityPrices'] = instance.quantityPrices;
  }
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
  if (instance.deliveryTypeId != null) {
    json['deliveryTypeId'] = instance.deliveryTypeId;
  }
  if (instance.supplierId != null) json['supplierId'] = instance.supplierId;
  if (instance.brandId != null) json['brandId'] = instance.brandId;
  if (instance.manufacturerId != null) {
    json['manufacturerId'] = instance.manufacturerId;
  }
  if (instance.originCountryId != null) {
    json['originCountryId'] = instance.originCountryId;
  }
  if (instance.importerCountryId != null) {
    json['importerCountryId'] = instance.importerCountryId;
  }
  if (instance.distributorId != null) {
    json['distributorId'] = instance.distributorId;
  }
  if (instance.itemTypeId != null) json['itemTypeId'] = instance.itemTypeId;
  if (instance.classificationId != null) {
    json['classificationId'] = instance.classificationId;
  }
  if (instance.subClassificationId != null) {
    json['subClassificationId'] = instance.subClassificationId;
  }
  if (instance.categoryId != null) json['categoryId'] = instance.categoryId;
  if (instance.subCategoryId != null) {
    json['subCategoryId'] = instance.subCategoryId;
  }
  if (instance.tagId != null) json['tagId'] = instance.tagId;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.hasVariant != null) json['hasVariant'] = instance.hasVariant;
  if (instance.hasUnit != null) json['hasUnit'] = instance.hasUnit;
  if (instance.departmentUnitId != null) {
    json['departmentUnitId'] = instance.departmentUnitId;
  }
  if (instance.departmentSubUnitId != null) {
    json['departmentSubUnitId'] = instance.departmentSubUnitId;
  }
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
  if (instance.returnTypeId != null) {
    json['returnTypeId'] = instance.returnTypeId;
  }
  if (instance.image != null) json['image'] = instance.image;
  if (instance.packageTypeId != null) {
    json['packageTypeId'] = instance.packageTypeId;
  }
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

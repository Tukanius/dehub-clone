part of '../models/supplier_businesses.dart';

SupplierBusinesses _$SupplierBusinessesFromJson(Map<String, dynamic> json) {
  return SupplierBusinesses(
    id: json['id'] as String,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    purchaseType:
        json['purchaseType'] != null ? json['purchaseType'] as String : null,
    profileNameEng: json['profileNameEng'] != null
        ? json['profileNameEng'] as String
        : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    productCategoryType: json['productCategoryType'] != null
        ? json['productCategoryType'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    businessStatus: json['businessStatus'] != null
        ? json['businessStatus'] as String
        : null,
  );
}

Map<String, dynamic> _$SupplierBusinessesToJson(SupplierBusinesses instance) {
  Map<String, dynamic> json = {};

  json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.purchaseType != null) {
    json['purchaseType'] = instance.purchaseType;
  }
  if (instance.profileNameEng != null) {
    json['profileNameEng'] = instance.profileNameEng;
  }
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.productCategoryType != null) {
    json['productCategoryType'] = instance.productCategoryType;
  }
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.businessStatus != null) {
    json['businessStatus'] = instance.businessStatus;
  }

  return json;
}

part of '../models/purchase_types.dart';

PurchaseTypes _$PurchaseTypesFromJson(Map<String, dynamic> json) {
  return PurchaseTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PurchaseTypesToJson(PurchaseTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

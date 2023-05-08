part of '../models/purchase_types.dart';

PurchaseTypes _$PurchaseTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PurchaseTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PurchaseTypesToJson(PurchaseTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

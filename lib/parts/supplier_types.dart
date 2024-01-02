part of "../models/supplier_types.dart";

SupplierTypes _$SupplierTypesFromJson(Map<String, dynamic> json) {
  return SupplierTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$SupplierTypesToJson(SupplierTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
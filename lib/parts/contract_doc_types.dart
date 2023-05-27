part of '../models/contract_doc_types.dart';

ContractDocTypes _$ContractDocTypesFromJson(Map<String, dynamic> json) {
  return ContractDocTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ContractDocTypesToJson(ContractDocTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

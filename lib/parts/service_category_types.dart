part of '../models/service_category_types.dart';

ServiceCategoryTypes _$ServiceCategoryTypesFromJson(Map<String, dynamic> json) {
  return ServiceCategoryTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ServiceCategoryTypesToJson(
    ServiceCategoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

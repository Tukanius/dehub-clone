part of '../models/service_category_types.dart';

ServiceCategoryTypes _$ServiceCategoryTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return ServiceCategoryTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$ServiceCategoryTypesToJson(
    ServiceCategoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

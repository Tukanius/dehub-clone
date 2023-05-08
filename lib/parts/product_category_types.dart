part of '../models/product_category_types.dart';

ProductCategoryTypes _$ProductCategoryTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return ProductCategoryTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$ProductCategoryTypesToJson(
    ProductCategoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

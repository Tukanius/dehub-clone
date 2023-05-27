part of '../models/product_category_types.dart';

ProductCategoryTypes _$ProductCategoryTypesFromJson(Map<String, dynamic> json) {
  return ProductCategoryTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ProductCategoryTypesToJson(
    ProductCategoryTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

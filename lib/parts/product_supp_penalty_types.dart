part of '../models/product_supp_penalty_types.dart';

ProductSuppPenaltyTypes _$ProductSuppPenaltyTypesFromJson(
    Map<String, dynamic> json) {
  return ProductSuppPenaltyTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ProductSuppPenaltyTypesToJson(
    ProductSuppPenaltyTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

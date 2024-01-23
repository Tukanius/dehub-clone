part of '../models/product_buyer_penalty_types.dart';

ProductBuyerPenaltyTypes _$ProductBuyerPenaltyTypesFromJson(
    Map<String, dynamic> json) {
  return ProductBuyerPenaltyTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ProductBuyerPenaltyTypesToJson(
    ProductBuyerPenaltyTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

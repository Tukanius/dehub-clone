part of '../models/product_buyer_fee_rules.dart';

ProductBuyerFeeRules _$ProductBuyerFeeRulesFromJson(Map<String, dynamic> json) {
  return ProductBuyerFeeRules(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ProductBuyerFeeRulesToJson(
    ProductBuyerFeeRules instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

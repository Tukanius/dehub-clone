part of '../models/price_group_types.dart';

PriceGroupTypes _$PriceGroupTypesFromJson(Map<String, dynamic> json) {
  return PriceGroupTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PriceGroupTypesToJson(PriceGroupTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

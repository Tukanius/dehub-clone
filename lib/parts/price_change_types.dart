part of "../models/price_change_types.dart";

PriceChangeTypes _$PriceChangeTypesFromJson(Map<String, dynamic> json) {
  return PriceChangeTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PriceChangeTypesToJson(PriceChangeTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

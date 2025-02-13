part of "../models/price_end_types.dart";

PriceEndTypes _$PriceEndTypesFromJson(Map<String, dynamic> json) {
  return PriceEndTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PriceEndTypesToJson(PriceEndTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

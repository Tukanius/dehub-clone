part of "../models/price_change_types.dart";

PriceChangeTypes _$PriceChangeTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PriceChangeTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PriceChangeTypesToJson(PriceChangeTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

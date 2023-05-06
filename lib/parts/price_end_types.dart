part of "../models/price_end_types.dart";

PriceEndTypes _$PriceEndTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PriceEndTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PriceEndTypesToJson(PriceEndTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

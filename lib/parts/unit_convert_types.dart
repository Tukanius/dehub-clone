part of "../models/unit_convert_types.dart";

UnitConvertTypes _$UnitConvertTypesFromJson(Map<String, dynamic> json) {
  return UnitConvertTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$UnitConvertTypesToJson(UnitConvertTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

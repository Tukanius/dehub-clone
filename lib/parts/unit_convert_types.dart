part of "../models/unit_convert_types.dart";

UnitConvertTypes _$UnitConvertTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json[code] != null) code = json['code'];
  if (json[name] != null) name = json['name'];

  return UnitConvertTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$UnitConvertTypesToJson(UnitConvertTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

part of "../models/per_types.dart";

PerTypes _$PerTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PerTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PerTypesToJson(PerTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

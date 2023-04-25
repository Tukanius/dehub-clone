part of "../models/return_types.dart";

ReturnTypes _$ReturnTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json[code] != null) code = json['code'];
  if (json[name] != null) name = json['name'];

  return ReturnTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$ReturnTypesToJson(ReturnTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

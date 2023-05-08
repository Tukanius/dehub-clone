part of '../models/reference_types.dart';

ReferenceTypes _$ReferenceTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return ReferenceTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$ReferenceTypesToJson(ReferenceTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

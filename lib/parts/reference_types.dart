part of '../models/reference_types.dart';

ReferenceTypes _$ReferenceTypesFromJson(Map<String, dynamic> json) {
  return ReferenceTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$ReferenceTypesToJson(ReferenceTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

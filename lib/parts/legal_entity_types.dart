part of '../models/legal_entity_types.dart';

LegalEntityTypes _$LegalEntityTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return LegalEntityTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$LegalEntityTypesToJson(LegalEntityTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

part of '../models/legal_entity_types.dart';

LegalEntityTypes _$LegalEntityTypesFromJson(Map<String, dynamic> json) {
  return LegalEntityTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$LegalEntityTypesToJson(LegalEntityTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

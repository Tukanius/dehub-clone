part of '../models/partner_types.dart';

PartnerTypes _$PartnerTypesFromJson(Map<String, dynamic> json) {
  return PartnerTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PartnerTypesToJson(PartnerTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

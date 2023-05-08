part of '../models/partner_types.dart';

PartnerTypes _$PartnerTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PartnerTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PartnerTypesToJson(PartnerTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

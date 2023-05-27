part of '../models/partner_classifications.dart';

PartnerClassifications _$PartnerClassificationsFromJson(
    Map<String, dynamic> json) {
  return PartnerClassifications(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$PartnerClassificationsToJson(
    PartnerClassifications instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

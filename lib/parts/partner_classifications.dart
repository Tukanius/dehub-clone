part of '../models/partner_classifications.dart';

PartnerClassifications _$PartnerClassificationsFromJson(
    Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return PartnerClassifications(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$PartnerClassificationsToJson(
    PartnerClassifications instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

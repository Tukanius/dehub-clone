part of '../models/equity_types.dart';

EquityTypes _$EquityTypesFromJson(Map<String, dynamic> json) {
  return EquityTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$EquityTypesToJson(EquityTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

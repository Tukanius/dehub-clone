part of '../models/equity_types.dart';

EquityTypes _$EquityTypesFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return EquityTypes(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$EquityTypesToJson(EquityTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
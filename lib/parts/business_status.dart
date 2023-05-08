part of '../models/business_status.dart';

BusinessStatus _$BusinessStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return BusinessStatus(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$BusinessStatusToJson(BusinessStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

part of '../models/zip_codes.dart';

ZipCodes _$ZipCodesFromJson(Map<String, dynamic> json) {
  return ZipCodes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    parent: json['parent'] != null ? json['parent'] as String : null,
    zone: json['zone'] != null ? json['zone'] as String : null,
  );
}

Map<String, dynamic> _$ZipCodesToJson(ZipCodes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.parent != null) json['parent'] = instance.parent;
  if (instance.zone != null) json['zone'] = instance.zone;

  return json;
}

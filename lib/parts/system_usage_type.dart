part of '../models/system_usage_type.dart';

SystemUsageType _$SystemUsageTypeFromJson(Map<String, dynamic> json) {
  return SystemUsageType(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$SystemUsageTypeToJson(SystemUsageType instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

part of '../models/warehouse_status.dart';

WarehouseStatus _$WarehouseStatusFromJson(Map<String, dynamic> json) {
  return WarehouseStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$WarehouseStatusToJson(WarehouseStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

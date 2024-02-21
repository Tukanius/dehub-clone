part of '../models/stock_movement_types.dart';

StockMovementTypes _$StockMovementTypesFromJson(Map<String, dynamic> json) {
  return StockMovementTypes(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$StockMovementTypesToJson(StockMovementTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
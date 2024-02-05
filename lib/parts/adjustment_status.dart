part of '../models/adjustment_status.dart';

AdjustmentStatus _$AdjustmentStatusFromJson(Map<String, dynamic> json) {
  return AdjustmentStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$AdjustmentStatusToJson(AdjustmentStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

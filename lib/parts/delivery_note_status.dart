part of '../models/delivery_note_status.dart';

DeliveryNoteStatus _$DeliveryNoteStatusFromJson(Map<String, dynamic> json) {
  return DeliveryNoteStatus(
    code: json['code'] != null ? json['code'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$DeliveryNoteStatusToJson(DeliveryNoteStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

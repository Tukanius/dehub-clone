part of '../models/order_status.dart';

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) {
  return OrderStatus(
    code: json['code'] != null ? json['code'] as String : null,
    sentName: json['sentName'] != null ? json['sentName'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
    receivedName:
        json['receivedName'] != null ? json['receivedName'] as String : null,
  );
}

Map<String, dynamic> _$OrderStatusToJson(OrderStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.sentName != null) json['sentName'] = instance.sentName;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.receivedName != null)
    json['receivedName'] = instance.receivedName;

  return json;
}

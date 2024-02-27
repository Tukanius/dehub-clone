part of "../models/settlement_status.dart";

SettlementStatus _$SettlementStatusFromJson(Map<String, dynamic> json) {
  return SettlementStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$SettlementStatusToJson(SettlementStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

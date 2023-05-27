part of "../models/partner_register_status.dart";

PartnerRegisterStatus _$PartnerRegisterStatusFromJson(
    Map<String, dynamic> json) {
  return PartnerRegisterStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    color: json['color'] != null ? json['color'] as Color : null,
  );
}

Map<String, dynamic> _$PartnerRegisterStatusToJson(
    PartnerRegisterStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.color != null) json['color'] = instance.color;

  return json;
}

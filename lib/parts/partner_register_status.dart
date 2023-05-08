part of "../models/partner_register_status.dart";

PartnerRegisterStatus _$PartnerRegisterStatusFromJson(
    Map<String, dynamic> json) {
  String? code;
  String? name;
  Color? color;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];
  if (json['color'] != null) color = json['color'];

  return PartnerRegisterStatus(
    code: code,
    name: name,
    color: color,
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

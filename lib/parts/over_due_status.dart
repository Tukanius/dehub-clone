part of "../models/over_due_status.dart";

OverDueStatus _$OverDueStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? color;
  String? name;

  if (json[color] != null) color = json['color'];
  if (json[code] != null) code = json['code'];
  if (json[name] != null) name = json['name'];

  return OverDueStatus(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$OverDueStatusToJson(OverDueStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.color != null) json['color'] = instance.color;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}

part of "../models/invitation_status.dart";

InvitationStatus _$InvitationStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;
  String? receivedName;
  String? color;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];
  if (json['receivedName'] != null) receivedName = json['receivedName'];
  if (json['color'] != null) color = json['color'];

  return InvitationStatus(
    code: code,
    name: name,
    receivedName: receivedName,
    color: color,
  );
}

Map<String, dynamic> _$InvitationStatusToJson(InvitationStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.receivedName != null)
    json['receivedName'] = instance.receivedName;

  return json;
}
